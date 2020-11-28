//
//  Factory.swift
//  Runner
//
//  Created by 刘隆昌 on 2020/9/4.
//

import Foundation
import SnapKit

typealias ConstraintMakerClosure = ((_ make: ConstraintMaker) -> Void)?

class Factory: NSObject {

    static func add<T: UIView>(_ subView: T, _ superView: T, _ closure: ConstraintMakerClosure = nil)->Factory.Type {
        superView.addSubview(subView)
        if let block = closure {
            subView.snp.makeConstraints(block)
        }
        return self
    }

    static func makeAview<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UIView {
        let view = UIView()
        _ = Factory.add(view, toView, closure)
        return view
    }

    static func makeALabel<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UILabel {
        let view = UILabel()
        _ = Factory.add(view, toView, closure)
        return view
    }

    static func makeAButton<T: UIView>(_ toView: T?, _ closure: ConstraintMakerClosure) -> UIButton {
        let view = UIButton()
        if toView != nil {
            _ = Factory.add(view, toView!, closure)
        } else {

        }
        return view
    }

    static func makeAButton<T: UIView>(_ toView: T?, _ size: CGSize) -> UIButton {
        let view = UIButton()
        view.bounds = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 100, height: 40))
        if toView != nil {
            toView!.addSubview(view)
        } else {

        }
        return view
    }

    static func makeAImgView<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UIImageView {
        let view = UIImageView()
        _ = Factory.add(view, toView, closure)
        return view
    }

    static func makeATextField<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UITextField {
        let view = UITextField.init(frame: CGRect.zero)
        _ = Factory.add(view, toView, closure)
        return view
    }
    
    static func makeATextView<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UITextView {
        let textView = UITextView.init(frame: .zero)
        toView.addSubview(textView)
        textView.snp.makeConstraints(closure!)
        return textView
    }
    
    static func insertOneImgView(_ fatherView: UIView) {
        let imgView = Factory.makeAImgView(fatherView) { (make) in
            make.left.right.top.bottom.equalTo(fatherView)
            }.image_lc("bgAllScreen")
        imgView.contentMode = .scaleAspectFit
    }

    static func aTableView<T: UIView>(_ toView: T, _ closure: ConstraintMakerClosure) -> UITableView {
        let tabView = UITableView.init(frame: CGRect.zero, style: .plain)
        toView.addSubview(tabView)
        tabView.snp.makeConstraints(closure!)
        return tabView
    }

}

extension UIButton {

    func title_lc(_ str: String, _ state: UIControl.State = .normal) -> UIButton {
        self.setTitle(str, for: state)
        return self
    }

    func titleColor_lc(_ color: UIColor, _ state: UIControl.State = .normal) -> UIButton {
        self.setTitleColor(color, for: state)
        return self
    }

    func radius_lc(_ radius: CGFloat) -> UIButton {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        return self
    }

    func image_lc(_ imgName: String) -> UIButton {
        self.setImage(UIImage.init(named: imgName), for: .normal)
        return self
    }

    func bgImage_lc(_ imgName: String) -> UIButton {
        self.setBackgroundImage(UIImage.init(named: imgName), for: .normal)
        return self
    }

    func addTarget_lc(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIButton {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }

    func titleFont_Regular_lc(_ size: CGFloat) -> UIButton {
        self.titleLabel?.font = fontRegularSize(size)
        return self
    }

    func titleFont_Medium_lc(_ size: CGFloat) -> UIButton {
        self.titleLabel?.font = fontMediumSize(size)
        return self
    }

    func titleFont_Bold_lc(_ size: CGFloat) -> UIButton {
        self.titleLabel?.font = fontBoldSize(size)
        return self
    }

    func titleFont_System_lc(_ size: CGFloat) -> UIButton {
        self.titleLabel?.font = fontSystemSize(size)
        return self
    }

}

extension UIView {

    func frame_lc(_ xOri: CGFloat, _ yOri: CGFloat, _ width: CGFloat, _ height: CGFloat) -> UIView {
        self.frame = CGRect.init(x: xOri, y: yOri, width: width, height: height)
        return self
    }

    func cornerRadius(_ value: CGFloat) -> UIView {
        self.layer.cornerRadius = value
        self.clipsToBounds = true
        return self
    }

}

extension UILabel {

    func text_lc(_ str: String) -> UILabel {
        self.text = str
        return self
    }

    func alignment_lc(_ align: NSTextAlignment) -> UILabel {
        self.textAlignment = align
        return self
    }

    func font_lc(_ value: CGFloat) -> UILabel {
        self.font = UIFont.systemFont(ofSize: value)
        return self
    }

    func font_Medium(_ value: CGFloat) -> UILabel {
        self.font = fontMediumSize(value)
        return self
    }

    func textAlignment_lc(_ alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }

    func font_Regular(_ value: CGFloat) -> UILabel {
        self.font = fontRegularSize(value)
        return self
    }

    func font_Heavy(_ value: CGFloat) -> UILabel {
        self.font = fontHeavySize(value)
        return self
    }

    func font_Bold(_ value: CGFloat) -> UILabel {
        self.font = fontBoldSize(value)
        return self
    }

    func font_System_Size(_ value: CGFloat) -> UILabel {
        self.font = fontSystemSize(value)
        return self
    }

    func attrText_lc(_ str: String, _ attr: [NSAttributedString.Key: Any]? = nil) -> UILabel {
        let attStr = NSMutableAttributedString.init(string: str)
        if attr != nil {
            attStr.addAttributes(attr!, range: NSRange.init(location: 0, length: str.count-1))
        }
        self.attributedText = attStr
        return self
    }

}

extension UIImageView {

    func image_lc(_ name: String) -> UIImageView {
        if let img = UIImage.init(named: name) {
            self.image = img
        }
        return self
    }

}

extension UITextField {

    func placeholder_lc(_ str: String?) -> UITextField {
        self.placeholder = str
        return self
    }

    func font_Media_lc(_ size: CGFloat) -> UITextField {
        self.font = fontMediumSize(size)
        return self
    }

    func font_Regular_lc(_ size: CGFloat) -> UITextField {
        self.font = fontRegularSize(size)
        return self
    }

    func font_Bold_lc(_ size: CGFloat) -> UITextField {
        self.font = fontBoldSize(size)
        return self
    }

    func borderStyle_lc(_ style: BorderStyle) -> UITextField {
        self.borderStyle = style
        return self
    }

}

extension UIViewController {

    func presentVc(desVc: UIViewController, animated: Bool = true) {
        desVc.modalPresentationStyle = .fullScreen
        self.present(desVc, animated: animated, completion: nil)
    }

}

extension UITableView {
    func delegateDataSource_lc(_ obj: UITableViewDelegate, _ source: UITableViewDataSource) -> UITableView {
        self.delegate = obj
        self.dataSource = source
        return self
    }
}
