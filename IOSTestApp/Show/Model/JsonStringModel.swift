//
//  JsonStringModel.swift
//  IOSTestApp
//
//  Created by 刘隆昌 on 2020/11/28.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit
import RealmSwift

class JsonStringModel: Object {
    //
    @objc dynamic var jsonStr = ""
    @objc dynamic var index = -1
    
    convenience init(_ jsonStr: String, _ idx: Int) {
        self.init()
        self.jsonStr = jsonStr
        self.index = idx
    }
    
}
