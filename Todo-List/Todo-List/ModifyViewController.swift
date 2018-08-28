//
//  ViewController.swift
//  Todo-List
//
//  Created by TaiHsinLee on 2018/8/28.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import UIKit

protocol DataModelDelegate: AnyObject {
    func didRecieveDataUpdate(data: [String])
}

class ModifyViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    static let storyboardName = "Main"
    static let viewControllerIdentifier = "ModifyViewController"
    var textContent = ""
    var data: [String] = []
    
    weak var delegate: DataModelDelegate?
    
    @IBAction func saveText(_ sender: UIButton) {
        guard let title = self.title else { fatalError() }
        data = [title, textView.text]
        print(title, textView.text)
        delegate?.didRecieveDataUpdate(data: data)
        navigationController?.popViewController(animated: true)
    }
    
//    func storeTextData () -> [String] {
//        guard let title = self.title else { fatalError() }
//        data = [title, textContent]
//        return data
//    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textView.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        changeTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    class func modifyViewControllerForText(_ textContent: String) -> ModifyViewController {
        let storyboard = UIStoryboard(name: ModifyViewController.storyboardName, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: ModifyViewController.viewControllerIdentifier)
            as? ModifyViewController else {
                
            return ModifyViewController()
        }
        
        viewController.textContent = textContent
        return viewController
    }
    
    func changeTitle() {
        if textContent == "" {
            textView.text = ""
            self.title = "Add"
            
        } else {
            textView.text = textContent
            self.title = "Edit"
        }
    }
}

