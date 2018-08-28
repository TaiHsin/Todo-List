//
//  TextViewController.swift
//  Todo-List
//
//  Created by TaiHsinLee on 2018/8/28.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {

//    @IBOutlet weak var addLabel: UIBarButtonItem!
    @IBOutlet var todoTableView: UITableView!
    
    @IBAction func addText(_ sender: Any) {
        let selectedText = ""
        let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
        
        navigationController?.pushViewController(modifyViewController, animated: true)
        
    }
    
    
    var textContent: [String] = ["test1", "test2", "test3", "test4", "test5"]
    var indexPathRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        todoTableView.delegate = self
        todoTableView.dataSource = self
        
        let newNib = UINib(nibName: "TextTableViewCell", bundle: nil)
        todoTableView.register(newNib, forCellReuseIdentifier: "TextTableViewCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        indexPathRow = indexPath.row
//    }
    
    @objc func editText(sender: UIButton) {
        let selectedText = textContent[sender.tag]
        let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
        
        navigationController?.pushViewController(modifyViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
            self.textContent.remove(at: indexPath.row)
            todoTableView.deleteRows(at: [indexPath], with: .fade)
//        }
        todoTableView.reloadData()
    }
}

extension TextViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
