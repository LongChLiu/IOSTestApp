//
//  NetWorkTool.swift
//  iOSTest
//
//  Created by 刘隆昌 on 2020/11/26.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import Foundation
import Alamofire

typealias ApiSuccessClosure = (Any) -> Void
typealias ApiFailureClosure = (Any) -> Void

enum Method {
    case GET
    case POST
}

let timeoutInterval = TimeInterval(10)

class NetworkTool: NSObject {
    //私有化初始化方法  生成单例
    private override init() {

    }

    static let share = NetworkTool()

    static let configuration = URLSessionConfiguration.default

    //swiftlint: disable line_length
    func request(path: String, params: [ String: String], method: Method, success: @escaping ApiSuccessClosure, fail: @escaping ApiFailureClosure) {

        let url = baseUrl + path

        let headerNormal: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        if method == Method.GET {

            AF.request(url).responseJSON { (data: AFDataResponse<Any>) in

                switch data.result {
                case .success:
                        let dic = data.value
                        print("数据:  \(String(describing: dic))")
                        success(dic ?? [:])
                case .failure:
                        let error = data.error
                        fail(error ?? "")
                }

            }

        } else if method == Method.POST {
            //swiftlint: disable line_length
            AF.request(url, method: .post, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headerNormal).responseJSON { (data: AFDataResponse<Any>) in
                switch data.result {
                case .success:
                        let dic = data.value
                        print("数据:  \(String(describing: dic))")
                case .failure:
                        let error = data.error
                        fail(error ?? "")
                }
            }
        }
    }
}
