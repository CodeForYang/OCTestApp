//
//  UIView+HUD.swift
//  TGToolsKit
//
//  Created by 杨佩 on 2022/3/17.
//

import Foundation

public extension UIView {
    
    //MARK: ====================对象方法

    
    /// 对象方法
    /// - Parameter msg: 纯文本显示
    ///   - enterAction: 默认不允许交互
    func showMessage(_ msg: String, _ enterAction:Bool = false) {
        let contentView = TGHudContentView.config(with: msg)
        
        let w = TGHudWindow.configPureText(with: contentView, complete: nil)
        if enterAction {
            addSubview(w)
        } else {
            window?.addSubview(w)
        }
        
    }
    
    
    /// 对象方法 - 带图片
    /// - Parameters:
    ///   - msg: 提示文字
    ///   - detail: 详情文字
    ///   - enterAction: 默认不允许交互
    func showNotice(_ msg: String, detail: String?, _ enterAction:Bool = false) {
        let contentView = TGHudContentView.config(with: IconFont.成功0, mTitle: msg, sTitle: detail)
        
        let w = TGHudWindow.config(with: contentView, complete: nil)
        if enterAction {
            addSubview(w)
        } else {
            window?.addSubview(w)
        }
        
    }
    
    //MARK: ====================类方法
    /// 类方法
    /// - Parameter msg: 纯文本显示
    static func showMessage(_ msg: String) {
        guard let currenvc = TGBaseViewController.getCurrentVC() else { return }
        currenvc.view.showMessage(msg)
    }

    /// 类方法 - 带图片
    /// - Parameters:
    ///   - msg: 提示文字
    ///   - detail: 详情文字
    static func showNotice(_ msg: String, detail: String?) {
        
        guard let currenvc = TGBaseViewController.getCurrentVC() else { return }

        currenvc.view.showNotice(msg, detail:detail)

    }
}
