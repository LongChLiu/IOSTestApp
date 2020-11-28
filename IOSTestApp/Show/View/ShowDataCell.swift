//
//  ShowDataCell.swift
//  iOSTest
//
//  Created by 刘隆昌 on 2020/11/27.
//  Copyright © 2020 刘隆昌. All rights reserved.
//

import UIKit

class ShowDataCell: UITableViewCell {

    lazy var showLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textColor = .darkGray
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .purple
        weak var weakSelf: ShowDataCell! = self
        contentView.addSubview(showLabel)
        showLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(weakSelf.contentView).offset(10)
            make.bottom.right.equalTo(weakSelf.contentView).offset(-10)
        }
        showLabel.numberOfLines = 0
        showLabel.backgroundColor = .yellow
        showLabel.textColor = .red
    }

    func configure(_ model: JsonStringModel) {
        self.showLabel.text = model.jsonStr
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
