//
//  TextTableViewCell.swift
//  Todo-List
//
//  Created by TaiHsinLee on 2018/8/28.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    
    @IBOutlet weak var textLable: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editText(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editButton.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
