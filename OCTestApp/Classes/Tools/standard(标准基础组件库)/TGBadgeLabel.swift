//
//  TGBadgeLabel.swift
//  TGToolsKit
//
//  Created by 杨佩 on 2022/3/14.
//

import UIKit
//MARK: ====================红点&数字 Label 效果如下
//https://sm.ms/image/jDcHLQ6KIbERuGk

public enum badgeType {
    case number//数字
    case new//new
    case dot//.
}

@objcMembers
open class TGBadgeLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        numberOfLines = 1
        textAlignment = .center
        lineBreakMode = .byTruncatingTail
        backgroundColor = .init(hexString: "FA5246")
        textColor = .white
        font = .systemFont(ofSize: 12)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 设置 红点 & 数字 & New 类方法 --- 布局请使用 XXX.snp.update..... 因为 frame 会更新
    /// - Parameters:
    ///   - type: 默认数字类型, 其他传相应类型
    /// - Returns: 返回标准大小 Label
    public static func badge(with type: badgeType = .number) -> TGBadgeLabel {
        let l = TGBadgeLabel()
        
        l.config(num: nil, type: type)
        l.layer.cornerRadius = type == .dot ? 4 : 8
        l.clipsToBounds = true
        return l
    }
    
    public func update(num: Int?) {
        config(num: num, type: .number)
    }

    
    private func config(num: Int?, type: badgeType) {
        
        var w: CGFloat = 16, h: CGFloat = 16
        
        switch type {
        
        case .dot:
            text = ""
            w = 8; h = 8
        case .new:
            text = "New"
            font = .systemFont(ofSize: 11)
            w = 32.5; h = 16

        case .number:
            
            guard let c = num, c > 0 else { return }

            if c < 10 {
                text = "\(c)"
                w = 16; h = 16
            } else if c < 99 {
                text = "\(c)"
                w = 25; h = 16
            } else {
                text = "99+"
                w = 32; h = 16
            }
            
        }
        
        var f = frame
        f.size = CGSize(width: w, height: h)
        frame = f
        
    }
}
