//
//  DataModelManager.swift
//  Todo-List
//
//  Created by TaiHsinLee on 2018/8/28.
//  Copyright © 2018年 TaiHsinLee. All rights reserved.
//

import Foundation

protocol DataModelDelegate: AnyObject {
    func didRecieveDataUpdate(data: String)
}

class DataModel {
    
    weak var delegate: DataModelDelegate?
    
    func requestData() {
        
        let data = "Data from wherever"
        delegate?.didRecieveDataUpdate(data: data)
    }
}
