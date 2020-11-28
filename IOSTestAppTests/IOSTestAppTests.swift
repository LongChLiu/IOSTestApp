//
//  IOSTestAppTests.swift
//  IOSTestAppTests
//
//  Created by 刘隆昌 on 2020/11/27.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import XCTest
@testable import IOSTestApp

class IOSTestAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let _ = DataBase.share.queryRecords()
        }
    }

    func testJsonStringModel() throws {
        let jsonModel0 = JsonStringModel.init("字符串", 0)
        let jsonModel1 = JsonStringModel.init()
        XCTAssert(jsonModel0.jsonStr == "字符串" && jsonModel0.index == 0, "数据初始化成功")
        XCTAssert(jsonModel1.jsonStr == "" && jsonModel1.index == -1, "原始数据")
    }
    
    func testDataBaseOpen() throws {
        let dataBase0 = DataBase.share
        let dataBase1 = DataBase.share
        XCTAssert(dataBase0 == dataBase1, "数据库工具单例")
    }
    
    
    func testDataBaseModeliSNull() throws {
        let models = DataBase.share.queryRecords()
        XCTAssert(models.count >= 0, "查询结果永不为空对象")
    }
    
    func testDataInsertData() throws {
        let isSuccess0 = DataBase.share.insertRecords(JsonStringModel())
        XCTAssert(isSuccess0 == false, "插入数据失败")
        let isSuccess1 = DataBase.share.insertRecords(JsonStringModel.init("JSON", 0))
        XCTAssert(isSuccess1 == true, "插入数据成功")
    }
    
}
