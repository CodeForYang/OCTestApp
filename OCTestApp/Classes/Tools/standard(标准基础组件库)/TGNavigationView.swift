//
//  TGNavigationView.swift
//  SwiftApp
//
//  Created by 杨佩 on 2022/3/30.
//

import UIKit

public protocol TGNavigationViewDelegate {
    func dismissButtonDidClick()
    func gobackButtonDidClick()
    
}

@objcMembers
public class TGNavigationView: UIView {

    //MARK: ====================私有属性
    
    private lazy var leftView: UIView = {
        let l = UIView()
        l.backgroundColor = .clear
        l.addSubview(gobackButton)
        return l
    }()
    
    private lazy var rightView: UIView = {
        let r = UIView()
        r.backgroundColor = .clear
        r.addSubview(dismissButton)
        return r
    }()
    
    private lazy var titleView: UIView = {
        let t = UIView()
        t.backgroundColor = .clear
        return t
    }()
    
    private let titleH: CGFloat = 44
    private let titleMaxW = UIScreen.main.bounds.size.width * 0.75
    private let titleMinW = UIScreen.main.bounds.size.width * 0.6

    public var delegate: TGNavigationViewDelegate?
    private let buttonW: CGFloat = 24
    public var showGoback = false {
        didSet {
            gobackButton.isHidden = !showGoback
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 18)
        l.textAlignment = .center
        l.numberOfLines = 1
        l.textColor = .tg_defaultLabel(withAlpha: 1.0)
        return l
    }()
    
    private lazy var dismissButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle(IconFont.关闭, for: .normal)
        b.titleLabel?.font = .IconFont(s: 24)
        b.setTitleColor(.tg_defaultLabel(withAlpha: 1.0), for: .normal)
        b.addTarget(self, action: #selector(onDissmiss), for: .touchUpInside)
        return b
    }()
    
    private lazy var gobackButton: UIButton = {
        let b = UIButton(type: .custom)
        b.isHidden = true
        b.setTitle(IconFont.箭头_左_line, for: .normal)
        b.titleLabel?.font = .IconFont(s: 24)
        b.setTitleColor(.tg_defaultLabel(withAlpha: 1.0), for: .normal)
        b.addTarget(self, action: #selector(onGoback), for: .touchUpInside)
        return b
    }()
    
   
    
    //MARK: ====================实例化方法
    static func config(with titile: String?, d: TGNavigationViewDelegate?) -> TGNavigationView {
        let n = TGNavigationView()
        n.setupUI(t: titile)
        return n
    }
    
    
    /// 更新导航栏标题
    /// - Parameter t: 标题
    public func update(t: String) {
        titleLabel.text = t
        
    }
    
    private func setupUI(t: String?) {
        
        var w = titleMaxW
        if let t = t {
            titleLabel.text = t
            titleView.addSubview(titleLabel)
            let s = titleLabel.sizeThatFits(CGSize(width: 999, height: titleH))
            w = max(min(titleMaxW, s.width), titleMinW)
            titleLabel.snp.makeConstraints({$0.edges.equalToSuperview()})
        }
        
        rightView.addSubview(dismissButton)
        
        [leftView, rightView, titleView].forEach({addSubview($0)})
        
        titleView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.equalTo(titleH)
            $0.width.equalTo(w)
        })
        
        leftView.snp.makeConstraints({
            $0.left.equalToSuperview().offset(16)
            $0.right.equalTo(titleView.snp.left).offset(-8)
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        })
        
        rightView.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-16)
            $0.left.equalTo(titleView.snp.right).offset(8)
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        })
        
        var tmpL: UIView?
        leftView.subviews.forEach { v in
            
            v.snp.makeConstraints({
                if let l = tmpL {
                    $0.left.equalTo(l.snp.right).offset(8)
                } else {
                    $0.left.equalToSuperview()
                }
                $0.centerY.equalToSuperview()
                $0.height.equalToSuperview()
                $0.width.equalTo(buttonW)
            })
            tmpL = v
        }
        
        var tmpR: UIView?
        rightView.subviews.forEach { v in
            
            v.snp.makeConstraints({
                if let r = tmpR {
                    $0.right.equalTo(r.snp.left).offset(-8)
                } else {
                    $0.right.equalToSuperview()
                }
                $0.centerY.equalToSuperview()
                $0.height.equalToSuperview()
                $0.width.equalTo(buttonW)
            })
            tmpR = v
        }
        
    }
    
    //MARK: ====================公共方法

//    public func addLeftButton(b: UIButton) {
//        
//    }
//
//    public func addRightButton(b: UIButton) {
//
//    }
//
//    public func removeAllLeftButton() {
//
//    }
    
    @objc private func onDissmiss() {
        delegate?.dismissButtonDidClick()
    }
    
    @objc private func onGoback() {
        delegate?.gobackButtonDidClick()
    }
}
