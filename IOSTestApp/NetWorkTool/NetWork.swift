//
//  NetWork.swift
//  IOSTestApp
//
//  Created by 刘隆昌 on 2020/11/29.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation


enum NetWork {
    
    static func getJsonData(success:@escaping (Any)->Void,failure:@escaping (Any)->Void){
        NetworkTool.share.request(path: Api.appendingUrl, params: [:], method: .GET, success: { (data: Any) in
            
            success(data)
            
        }, fail: { (error: Any) in
            
            failure(error)
            
        })
    }
    
    
}
