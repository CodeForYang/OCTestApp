//
//  TGHudWindow.swift
//  SwiftApp
//
//  Created by 杨佩 on 2022/3/17.
//

import UIKit
import SnapKit

//MARK: ====================外部承载视图 效果如下(背景色区域)
//https://sm.ms/image/VdWLT6HFG9ND8kc


public typealias TGHudCompletionBlock = (()->())

@objcMembers
open class TGHudWindow: UIView {
    
    private static let w: CGFloat = 232, minW: CGFloat = 136, h: CGFloat = 161, minH: CGFloat = 62.5
    
    public static func configPureText(with contentView: UIView, complete:TGHudCompletionBlock?) -> TGHudWindow {
        return config(with: contentView, offsetY: 0, isPureText: true, complete: complete)
    }
    
    public static func config(with contentView: UIView, offsetY: Double = 0, duration: Double = 1.5, isPureText:Bool = false, complete:TGHudCompletionBlock?) -> TGHudWindow {
        let window = TGHudWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .clear
        
        //内容承载视图
        let rectView = UIView()
        rectView.backgroundColor = UIColor.init(red: 31/255.0, green: 37/255.0, blue: 51/255.0, alpha: 0.8)
        rectView.layer.cornerRadius = 8
        window.addSubview(rectView)
        
        //限制宽高
        var frame = contentView.frame
        frame.size.width = min(frame.size.width, w)
        frame.size.height = min(frame.size.height, h)
        frame.size.width = max(frame.size.width, minW)
        frame.size.height = max(frame.size.height, minH)

        contentView.frame = frame
        rectView.addSubview(contentView)
        
        rectView.snp.makeConstraints({
            
            if offsetY == 0 {
                $0.center.equalToSuperview()
            } else {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().offset(offsetY)
            }
            
            var contentW = frame.width + 20, contentH = frame.height
            if !isPureText {contentW += 20; contentH += 40}
            $0.size.equalTo(CGSize(width:  contentW, height: contentH))
            
        })
        
        contentView.snp.makeConstraints({
            $0.size.equalTo(frame.size)
            $0.center.equalToSuperview()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: { [weak window] in
            guard let weakWindow = window else { return }
            complete?()
            weakWindow.removeFromSuperview()
        })
        
        return window
    }

}
