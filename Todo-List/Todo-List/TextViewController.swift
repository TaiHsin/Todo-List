//
//  TextViewController.swift
//  Todo-List
//
//  Created by TaiHsinLee on 2018/8/28.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    var textContent: [String] = ["test1", "test2", "test3", "test4", "test5"]
    var indexPathRow = 0
    private let dataModel = DataModel()

    @IBOutlet var todoTableView: UITableView!
    
    @IBAction func addText(_ sender: Any) {
        let selectedText = ""
        let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
        
        navigationController?.pushViewController(modifyViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        let newNib = UINib(nibName: "TextTableViewCell", bundle: nil)
        todoTableView.register(newNib, forCellReuseIdentifier: "TextTableViewCell")

        dataModel.delegate = self
        dataModel.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Table View Data Source

extension TextViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell {
         
            cell.textLable.text = textContent[indexPath.row]
            cell.editButton.addTarget(self, action: #selector(self.editText), for: .touchUpInside)
            cell.editButton.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathRow = indexPath.row
    }
    
    @objc func editText(sender: UIButton) {
        let selectedText = textContent[sender.tag]
        let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
        
        navigationController?.pushViewController(modifyViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.textContent.remove(at: indexPath.row)
            todoTableView.deleteRows(at: [indexPath], with: .fade)
        }
        todoTableView.reloadData()
    }
}

// MARK: - Table View Delegate

extension TextViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - Data Manager Delegate

extension TextViewController: DataModelDelegate {
    func didRecieveDataUpdate(data: String) {
        print(data)
    }
}









