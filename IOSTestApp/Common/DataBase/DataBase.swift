//
//  DataBase.swift
//  iOSTest
//
//  Created by 刘隆昌 on 2020/11/27.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation
import RealmSwift

//swiftlint: disable trailing_whitespace
class DataBase: NSObject {
    private override init() {}
    static let share = DataBase()
    
    func queryRecords() -> [JsonStringModel] {
        //使用默认的数据库
        do {
            let realm = try Realm()
            let items = realm.objects(JsonStringModel.self)
            if items.count > 0 {
                return items.reversed()
            } else {
                return []
            }
        } catch {
            print("数据库打开异常")
            return []
        }
    }
    func insertRecords(_ item: JsonStringModel) -> Bool {
        
        if (item.jsonStr == "" || item.index == -1) {
            return false
        }
        
        //使用默认的数据库
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(item)
            }
            return true
        } catch {
            print("数据库打开异常")
            return false
        }
        //查询所有的消费记录
    }
}
