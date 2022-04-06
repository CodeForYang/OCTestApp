//
//  TGSwitch.swift
//  TGToolsKit
//
//  Created by 杨佩 on 2022/3/15.
//

import UIKit

//MARK: ====================开关 效果如下
//https://sm.ms/image/n37NhQ4KOIVlmbd

public enum TGSwitchStatus: NSInteger {
    case closeDefault, closeForbidden//默认关, 禁用关
    case openDefault, openForbidden//默认开, 禁用开
}

public typealias statusChangeBlock = ((_ isOn: Bool)->())

@objcMembers
open class TGSwitch: UISwitch {
    
    
    private var block: statusChangeBlock?
    
    
    /// 类方法-指定Switch状态
    /// - Parameters:
    ///   - status: 禁用状态下不可交互
    ///   - block: 默认情况下状态切换回调
    /// - Returns: 返回标准大小 Switch
    public static func config(status: TGSwitchStatus,  block: @escaping statusChangeBlock) -> TGSwitch {
        
        let s = TGSwitch()
        s.addTarget(s, action: #selector(switchValueChange(_:)), for: .valueChanged)
        s.block = block
        
        s.set(status: status)
        
        return s
    }

    @discardableResult
    public func `set`(status: TGSwitchStatus) -> Bool {
        if isUserInteractionEnabled == false {return false}
        var closeColor = UIColor.white
        switch status {
        case .closeDefault:
            isOn = false
            isUserInteractionEnabled = true
            closeColor = .tg_defaultLabel(withAlpha: 0.08)
            
            
        case .closeForbidden:
            isOn = false
            isUserInteractionEnabled = false
            closeColor = .tg_defaultLabel(withAlpha: 0.03)

        case .openDefault:
            isOn = true
            isUserInteractionEnabled = true
            onTintColor = .tg_mainTheme()
            
        case .openForbidden:
            isOn = true
            isUserInteractionEnabled = false
            onTintColor = .tg_mainThemeColor(withAlpha: 0.4)
        
        }
        
        tintColor = closeColor//边缘
        backgroundColor = closeColor
        layer.cornerRadius = bounds.height/2.0
        layer.masksToBounds = true
        
        return true
    }
    
    @objc private func switchValueChange(_ s: TGSwitch) {
        block?(s.isOn)
    }
}


