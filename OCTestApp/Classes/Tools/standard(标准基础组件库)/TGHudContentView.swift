//
//  TGHudContentView.swift
//  SwiftApp
//
//  Created by 杨佩 on 2022/3/17.
//

import UIKit


//MARK: ====================内容视图 效果如下(内容区域)
//https://sm.ms/image/VdWLT6HFG9ND8kc
//https://sm.ms/image/jodQD4sv1mXpF5M

@objcMembers
public class TGHudContentView: UIView {
    
    private lazy var IconLabel: UILabel = {
        let i = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        i.contentMode = .scaleAspectFill
        i.backgroundColor = .white
        return i
    }()
    
    private lazy var mTitle: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.textColor = .white
        l.numberOfLines = 1
        l.lineBreakMode = .byCharWrapping
        l.textAlignment = .center
        return l
    }()
    
    private lazy var sTitle: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12)
        l.textColor = .white.withAlphaComponent(0.8)
        l.numberOfLines = 1
        l.lineBreakMode = .byCharWrapping
        l.textAlignment = .center
        return l
    }()
    
    
    public static func config(with imageStr: String, mTitle: String, sTitle: String?) -> TGHudContentView {
        return privateConfig(with: imageStr, mTitle: mTitle, sTitle: sTitle)
    }
    
    public static func config(with mTitle: String) -> TGHudContentView  {
        return privateConfig(with: nil, mTitle: mTitle, sTitle: nil)
    }
    
    private static func privateConfig(with imageStr: String?, mTitle: String, sTitle: String?) -> TGHudContentView {
        
        let view = TGHudContentView()
        var w: CGFloat = 0, h: CGFloat = 0;

        if let str = imageStr {
            view.IconLabel.text = str
            view.IconLabel.font = .init(name: "normalFont", size: 40);
//            view.IconLabel.image = UIImage(named: str)
            view.addSubview(view.IconLabel)
            
            view.IconLabel.snp.makeConstraints({
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview()
                $0.size.equalTo(CGSize(width: 40, height: 40))
            })
            
            w += 40
            h += 40
        }
        
        
        h += (12 + 22.5)
        view.mTitle.text = mTitle
        w += max(w, view.mTitle.sizeThatFits(CGSize(width: 666, height: 22.5)).width)
        view.addSubview(view.mTitle)
        view.mTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()

            if let _ = imageStr {
                $0.top.equalTo(view.IconLabel.snp.bottom).offset(12)
            } else {
                $0.centerY.equalToSuperview()
            }
        })
        
        if let s = sTitle {
            view.sTitle.text = s
            view.addSubview(view.sTitle)
            h += (4 + 16.5)
            w = max(w, view.sTitle.sizeThatFits(CGSize(width: 666, height: 16.5)).width)
            
            view.sTitle.snp.makeConstraints({
                $0.centerX.equalToSuperview()
                $0.left.equalToSuperview()
                $0.right.equalToSuperview()
                $0.top.equalTo(view.mTitle.snp.bottom).offset(4)
            })
        }
        
        view.frame = CGRect(x: 0, y: 0, width: w, height: h)
        return view
    }

}
