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
        
        
        let notificationName = Notification.Name("SAVE")
        NotificationCenter.default.addObserver(self, selector: #selector(saveText(notification:)), name: notificationName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func saveText(notification: Notification) {
        print("save success!!!")
        
        guard let textData = notification.userInfo as? [String: String] else { fatalError() }
        textContent[indexPathRow] = textData["textkey"]!
        todoTableView.reloadData()
    }

}

extension TextViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
//        indexPathRow = indexPath.row
    }
    
    @objc func editText(sender: UIButton) {
        indexPathRow = sender.tag
        let selectedText = textContent[indexPathRow]
        let modifyViewController = ModifyViewController.modifyViewControllerForText(selectedText)
        
        navigationController?.pushViewController(modifyViewController, animated: true)
    }
    
}

extension TextViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
