//
//  ViewController.swift
//  IOSTestApp
//
//  Created by 刘隆昌 on 2020/11/27.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class ViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    var textView: UITextView!
    var timesLabel: UILabel!
    var times: Int = 1
    var after: Int = 5
    var period: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeUI()
        beginBussiss()
    }
    
    /**跳转请求历史界面*/
    @objc func viewCallHistory(_ btn: UIButton) {
        let callVc = CallHistoryVC()
        self.navigationController?.pushViewController(callVc, animated: true)
    }
        
    @objc func requestData(_ time: Int) {
        let curTime = time
        weak var weakSelf: ViewController! = self
        NetworkTool.share.request(path: Api.appendingUrl, params: [:], method: .GET, success: { (data: Any) in
            if let dic: [ String: Any] = data as? [ String: Any] {
                weakSelf.textView.text = "当前显示第\(curTime)次服务端数据\n  \(dic.description)"
                let model = JsonStringModel.init(dic.description, curTime)
                _ = DataBase.share.insertRecords(model)
            }
        }, fail: { (error: Any) in
            let model = JsonStringModel.init("\(error)", curTime)
            _ = DataBase.share.insertRecords(model)
            weakSelf.textView.text = "第\(curTime)次服务端数据*请求错误\n  \(error)"
        })
    }
    
}

// MARK: - 业务逻辑处理
extension ViewController {
    @objc func beginBussiss() {
        timesLabel.text = "\(after)秒后发起请求..."
        times = DataBase.share.queryRecords().count
        
        weak var weakSelf: ViewController! = self
    
        let delay = RxTimeInterval.seconds(0)
        let beginTimer = Observable<Int>.timer(delay, period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        beginTimer.subscribe(onNext: { (time) in
            
            if time >= weakSelf.after {
                weakSelf.requestData(weakSelf.times)
                DispatchQueue.main.async {
                    weakSelf.timesLabel.text = "总计第\(weakSelf.times)次请求..."
                    weakSelf.times += 1
                }
            } else {
                weakSelf.timesLabel.text = "\(weakSelf.after-time)秒后发起请求..."
            }
            
        }).disposed(by: self.disposeBag)
    }
}

//创建UI
extension ViewController {
    @objc func makeUI() {
        weak var weakSelf: ViewController! = self
        let btn =  Factory.makeAButton(nil, CGSize(width: 100, height: 40)).title_lc("调用历史").titleColor_lc(.black)
        _ = btn.addTarget_lc(self, action: #selector(viewCallHistory(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        timesLabel = Factory.makeALabel(view) { (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }.font_Bold(14).textAlignment_lc(.center)
        
        textView = Factory.makeATextView(view) { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(weakSelf.timesLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-40)
        }
        textView.backgroundColor = .lightGray
        textView.font = fontMediumSize(14)
    }
}
