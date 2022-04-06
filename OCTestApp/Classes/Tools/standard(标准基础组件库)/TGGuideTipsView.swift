//
//  TGGuideToastView.swift
//  TGToolsKit
//
//  Created by 杨佩 on 2022/3/15.
//

import UIKit
import SnapKit

//MARK: ====================引导文字 效果如下
//https://sm.ms/image/8LbG9z7oPqhsHvY

public enum angleDirection {
    case left, right
    case topLeft, topCenter, topRight
    case bottomLeft, bottomCenter, bottomRight
}

enum direction {//内部使用
    case left, bottom, right, top
}

public typealias closeCompletionBlock = (()->())


public protocol TGGuideTipsViewDelegate: NSObjectProtocol {
    func closeButtonDidClick()
}

@objcMembers
public class TGGuideTipsView: UIView {

    
    private lazy var l: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.textColor = .white
        l.lineBreakMode = .byTruncatingTail
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 14)
        return l
    }()
    
    
    private lazy var maxLabelW: CGFloat = {
        if getDirection == .left, getDirection == .right {
            return UIScreen.main.bounds.size.width - contentMargin - angleH - margin
        }
        
        return UIScreen.main.bounds.size.width - contentMargin - margin
    }()
    
    private var lableW: CGFloat {
        get {
            ceil(l.sizeThatFits(CGSize(width: 666, height: l.font.lineHeight)).width)
        }
    }
    
    private var angleDirection: angleDirection = .bottomCenter

    private var closeButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setEnlargeEdge(10)
        b.setTitle(IconFont.关闭, for: .normal)
        b.titleLabel?.font = UIFont.init(name: "iconfont", size: 16)
        b.tintColor = UIColor.tg_mainTheme().withAlphaComponent(0.4)
        b.addTarget(self, action: #selector(onClose), for: .touchUpInside)
        b.backgroundColor = .clear
        return b
    }()
    
    private lazy var getCotentSize: CGSize = {
        var contentSize = frame.size
        if getDirection == .left || getDirection == .right {
            contentSize.width = contentSize.width - angleH - margin
        } else {
            contentSize.height = contentSize.height - angleH - margin
        }
        
        return contentSize
    }()
    
    
    private var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = .tg_mainTheme()
        v.layer.cornerRadius = 8
        
        v.layer.shadowColor = UIColor.tg_mainTheme().withAlphaComponent(0.4).cgColor
        v.layer.shadowOffset = CGSize(width: 0, height: 1)
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 8
        
        return v
    }()
    
        
    private lazy var triangelView = TriangleView()
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        var angle: CGFloat = 0
        switch getDirection {
        case .bottom :
            break
        case .left :
            angle = CGFloat.pi / 2
        case .top :
            angle = CGFloat.pi
        case .right :
            angle = -CGFloat.pi / 2
        }
        triangelView.backgroundColor = .clear
        triangelView.transform = CGAffineTransform(rotationAngle: angle)
        
    }
    

    @objc private func onClose() {
        completionBlock?()
        delegate?.closeButtonDidClick()
        delegate = nil

        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
        
    }
    
    private let defaultMargin: CGFloat = 40//topLeft, topRight,bottomLeft, bottomRight 默认40
    private let angleH: CGFloat = 5//三角形高度
    private let margin: CGFloat = 2//箭头与内容物的距离
    private let contentMargin: CGFloat = 8 + 16 + 16 + 12//除文字之外的内容宽度

    private lazy var getDirection: direction = {
        //方向
        var d:direction = .bottom
        
        if angleDirection == .left {
            d = .left
        } else if angleDirection == .right {
            d = .right
        } else if angleDirection == .topLeft ||
                    angleDirection == .topRight ||
                    angleDirection == .topCenter {
            d = .top
        } else {
            d = .bottom
        }
        
        return d
    }()
    
    private var completionBlock: closeCompletionBlock?
    public weak var delegate: TGGuideTipsViewDelegate?// 和closeCompletionBlock 二选一

    /// 带箭头的提示文字
    /// - Parameters:
    ///   - with: 文字内容 -值显示一行,超出内容...
    ///   - direction: 箭头方向, 总共八个方向, topLeft,离父控件左边40,以此类推
    ///   - completion: 点击回调,可为空
    /// - Returns: 返回标准提示大小
    public static func config(with :String, direction:angleDirection, _ completion:closeCompletionBlock?) -> TGGuideTipsView {
        let view = TGGuideTipsView()
        
        view.completionBlock = completion

        view.angleDirection = direction

        view.l.text = with
        
        view.setupFrame()
        
        view.setupUI(with: view.getDirection)
        
        return view
    }
    
    private func setupFrame() {

        var h: CGFloat = 36//内容高度
        
        if lableW > maxLabelW {//超出位置
            frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: h)
        } else {
            
            var viewW: CGFloat = lableW + contentMargin
            if angleDirection == .left || angleDirection == .right {
                viewW += angleH + margin
            } else {
                h = h + angleH + margin//箭头与内容物的距离
            }

            frame = CGRect(x: 0, y: 0, width: viewW, height: h)
        }
    }
    
    
    
    private func setupUI(with d: direction) {
        
        [contentView, triangelView].forEach({addSubview($0)})
        [l, closeButton].forEach({contentView.addSubview($0)})
        
        let traiangelSize = CGSize(width: 12, height: 6)
        let mudip = traiangelSize.height * 0.5//由于三角形旋转导致的宽高位置颠倒,导致的布局不准确, 修正偏移
        triangelView.snp.makeConstraints({
            
            $0.size.equalTo(traiangelSize)

            switch angleDirection {
                case .left:
                    $0.left.equalToSuperview().offset(margin - mudip)
                    $0.centerY.equalToSuperview()

                case .right:
                    $0.right.equalToSuperview().offset(-margin + mudip)
                    $0.centerY.equalToSuperview()

                case .topLeft:
                    $0.left.equalToSuperview().offset(defaultMargin)
                    $0.top.equalToSuperview()

                case .topCenter:
                    $0.centerX.top.equalToSuperview()

                case .topRight:
                    $0.right.equalToSuperview().offset(-defaultMargin)
                    $0.top.equalToSuperview()

                case .bottomLeft:
                    $0.left.equalToSuperview().offset(defaultMargin)
                    $0.bottom.equalToSuperview()

                case .bottomCenter:
                    $0.centerX.bottom.equalToSuperview()

                case .bottomRight:
                    $0.right.equalToSuperview().offset(-defaultMargin)
                    $0.bottom.equalToSuperview()
            }
            
        })
        
        
        contentView.snp.makeConstraints({
            
            switch getDirection {
                case .left:
                    $0.centerY.equalTo(triangelView)
                    $0.left.equalTo(triangelView.snp.right).offset(-mudip)
                    
                case .right:
                    $0.centerY.equalTo(triangelView)
                    $0.right.equalTo(triangelView.snp.left).offset(mudip)
                    
                case .top:
                    $0.centerX.equalToSuperview()
                    $0.top.equalTo(triangelView.snp.bottom)
                    
                case .bottom:
                    $0.centerX.equalToSuperview()
                    $0.bottom.equalTo(triangelView.snp.top)
            }
            
            $0.size.equalTo(getCotentSize)
        })
        
        closeButton.snp.makeConstraints({
            $0.size.equalTo(CGSize(width: 16, height: 12))
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-12)
        })
        
        l.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalTo(closeButton.snp.left).offset(-8)
            $0.left.equalToSuperview().offset(16)
        })
    }

}



public class TriangleView: UIView {
    var bgColor: UIColor = .tg_mainTheme()
    public var wi: CGFloat = 12, hi: CGFloat = 6
    override public func draw(_ rect: CGRect) {
        
        bgColor.set()
        
        let b = UIBezierPath()
        b.lineWidth = 1
        b.lineJoinStyle = .round
        b.move(to: .zero)
        b.addLine(to: CGPoint(x: hi, y: hi))
        b.addLine(to: CGPoint(x: wi, y: 0))
        b.addLine(to: .zero)
        b.fill()

        b.stroke()
    }
}

