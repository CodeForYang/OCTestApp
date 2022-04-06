//
//  TGView+.swift
//  TGToolsKit
//
//  Created by jf on 2020/8/26.
//

import UIKit
import Masonry

public protocol TGReusableId where Self: UIView {
    static var tg_reuseId: String { get }
}

public extension TGReusableId {
    static var tg_reuseId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: TGReusableId {}

extension UICollectionViewCell: TGReusableId {}

extension UICollectionReusableView: TGReusableId {}


extension UIView {
    
    @inlinable
    @discardableResult
    open func tg_addBottomLine(leftInset: CGFloat = 0, rightInset: CGFloat = 0, bottomInset: CGFloat = 0,
                                          lineColor: UIColor = UIColor.lightGray, lineWidth: CGFloat = (1.0 / UIScreen.main.scale)) -> UIView {
        let line = UIView()
        line.backgroundColor = lineColor
        addSubview(line)
        line.mas_makeConstraints { make in
            make?.left.equalTo()(self)?.offset()(leftInset)
            make?.right.equalTo()(self)?.offset()(-rightInset)
            make?.bottom.equalTo()(self)?.offset()(-bottomInset)
            make?.height.mas_equalTo()(lineWidth)
        }
        
        return line
    }
    
    /// 部分圆角
    open func tg_addCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}

extension UIView {
    
    open class func screnWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    open class func screnHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 标准设计屏幕宽度
    open class func standardUIWidth() -> CGFloat {
        return 375.0
    }
    
    /// 标准设计屏幕宽度比例
    open class func standardUIScale() -> CGFloat {
        return UIView.screnWidth() / UIView.standardUIWidth()
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 标准设计屏幕宽度
    public static var standardWidth: CGFloat {
        return 375.0
    }
    
    /// 标准设计屏幕宽度比例
    public static var standardScale: CGFloat {
        return UIView.screenWidth / UIView.standardWidth
    }
    
    /// 判断是否是刘海屏
    @objc
    open class func tg_isIphoneNotchScreen() -> Bool {
        var result = false
        
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.delegate?.window as? UIView {
                if window.safeAreaInsets.bottom > 0 {
                    result = true
                }
            }
        }
        
        return result
    }
    
}



// MARK: - xib
public protocol TGXibInstanceable: class {    
    static var tg_xibInstanceBundle: Bundle { get }
    static func tg_xibInstance() -> Self?
}


public extension TGXibInstanceable where Self: UIView {
    static var tg_xibInstanceBundle: Bundle { return Bundle.main }
    
    static func tg_xibInstance() -> Self? {
        return tg_xibInstanceBundle.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? Self
    }
}
