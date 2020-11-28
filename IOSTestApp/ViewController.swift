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
import RxCocoa

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
        
    @objc func requestData(_ time: Int) {
        let curTime = time
        NetWork.getJsonData(success: {[weak self] (data: Any) in
            
            if let dic: [ String: Any] = data as? [ String: Any] {
                self!.refreshTip("当前显示第\(curTime)次服务端数据\n  \(dic.description)")
                let model = JsonStringModel.init(dic.description, curTime)
                _ = DataBase.share.insertRecords(model)
            }
            
        }, failure: {[weak self] (error: Any) in
            
            let model = JsonStringModel.init("\(error)", curTime)
            _ = DataBase.share.insertRecords(model)
            self!.refreshTip("第\(curTime)次服务端数据*请求错误\n  \(error)")
            
        })
    }
    
    func refreshTip(_ str:String){
        DispatchQueue.main.async {
            self.textView.text = str
        }
    }
    
}

// MARK: - 业务逻辑处理
extension ViewController {
    
    @objc func beginBussiss() {
        timesLabel.text = "\(after)秒后发起请求..."
        times = DataBase.share.queryRecords().count
        let delay = RxTimeInterval.seconds(0)
        let beginTimer = Observable<Int>.timer(delay, period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        beginTimer.subscribe(onNext: {[weak self] (time) in
            
            if time >= self!.after {
                self!.requestData(self!.times)
                DispatchQueue.main.async {
                    self!.timesLabel.text = "总计第\(self!.times)次请求..."
                    self!.times += 1
                }
            } else {
                self!.timesLabel.text = "\(self!.after-time)秒后发起请求..."
            }
            
        }).disposed(by: self.disposeBag)
    }
    
}

//创建UI
extension ViewController {
    
    @objc func makeUI() {
        let btn =  Factory.makeAButton(nil, CGSize(width: 100, height: 40)).title_lc("调用历史").titleColor_lc(.black)
        btn.rx.tap.subscribe(onNext: {[weak self] in
            /**跳转请求历史界面*/
            let callVc = CallHistoryVC()
            self?.navigationController?.pushViewController(callVc, animated: true)
        }).disposed(by: self.disposeBag)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        timesLabel = Factory.makeALabel(view) { (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }.font_Bold(14).textAlignment_lc(.center)
        
        textView = Factory.makeATextView(view) {[weak self] (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(self!.timesLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-40)
        }
        textView.backgroundColor = .lightGray
        textView.font = fontMediumSize(14)
    }
    
}
