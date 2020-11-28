//
//  DetailVC.swift
//  IOSTestApp
//
//  Created by 刘隆昌 on 2020/11/28.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var textView: UITextView!
    var timesLabel: UILabel!
    var times: Int = 1
    var model: JsonStringModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "数据详情* 滑动查看文本"
        view.backgroundColor = .red
        makeUI()
    }
    
    func makeUI() {
        timesLabel = Factory.makeALabel(view) { (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }.font_Bold(14).textAlignment_lc(.center)
        
        weak var weakSelf: DetailVC! = self
        textView = Factory.makeATextView(view) { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(weakSelf.timesLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-40)
        }
        textView.backgroundColor = .white
        textView.font = fontMediumSize(14)
        textView.text = model.jsonStr
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
