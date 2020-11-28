//
//  CallHistoryVC.swift
//  iOSTest
//
//  Created by 刘隆昌 on 2020/11/27.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit
import RealmSwift
import MJRefresh

class CallHistoryVC: UIViewController {
    
    var tabView: UITableView!
    var dataArray: [JsonStringModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "点击条目*查看数据详情"
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        makeUI()
        refreshData()
    }
    
    func refreshData() {
        dataArray = DataBase.share.queryRecords()
        tabView.reloadData()
        tabView.mj_header?.endRefreshing()
    }
    
    func makeUI() {
        tabView = Factory.aTableView(view) { [weak self] (make) in
            make.left.right.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view)
        }.delegateDataSource_lc(self, self)
        
        tabView.register(ShowDataCell.self, forCellReuseIdentifier: "ShowDataCell")
        tabView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self!.refreshData()
        })
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

extension CallHistoryVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ShowDataCell = tableView.dequeueReusableCell(withIdentifier: "ShowDataCell", for: indexPath) as? ShowDataCell {
            
            let model: JsonStringModel = self.dataArray[indexPath.row]
            cell.configure(model)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        let model: JsonStringModel = self.dataArray[indexPath.row]
        let detailVc = DetailVC()
        detailVc.model = model
        self.navigationController?.pushViewController(detailVc, animated: true)
    }

}
