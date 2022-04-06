//
//  TGPopWindow.swift
//  SwiftApp
//
//  Created by 杨佩 on 2022/3/28.
//

import UIKit

public protocol TGPopWindowDelegate {
    func popWindowSetupUI()//基本设置
    func popWindowUpdateConstrains()//更新布局
    func popViewGobackButtonDidClick()
    func popViewDismissButtonDidClick()

}

@objcMembers
public class TGPopWindow: UIView {
   
    public enum PopType {
        case bubble//气泡 - 无动画
        case top//从顶部往下弹
        case bottomNoTitle//底部无标题
        case bottomTitle
        case center//中心
    }
    
    //MARK: ====================公有属性
    private var cBgView: ContentBgView?//内容物的背景
    public var contentView: UIView //需要展示的内容物
    public var bgColor: UIColor = UIColor.tg_maskBg() {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    
    /// 垂直偏移
    private var offsetY: CGFloat = 0
    
    //需要自定义控件布局的, 导航栏响应点击事件的遵守此代理
    public var delegate: TGPopWindowDelegate?
    
    //MARK: ====================私有属性
    private let cMaxH: CGFloat = UIScreen.main.bounds.size.height * 0.85
    private let cMinH: CGFloat = 190
    private let type: PopType
    private let animationDuration: TimeInterval = 0.4

    
    private var isHideWindow = false {
        didSet {
            isHidden = isHideWindow
        }
    }
    
    /// 点击背景是否响应
    public var bgUserInteraction = true
    
    
    /// 背景被点击
    @objc private func OnBackground() {
        dismiss(with: true, removeFromSuperView: false)
    }
    
    init(t: PopType, c: UIView) {
        type = t
        contentView = c
        
        super.init(frame: .zero)
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ====================公有方法
    
    static public func config(with t: PopType, c: UIView) -> TGPopWindow? {
        return TGPopWindow.config(with: t, c: c, nil, 0)
    }
    
    /// 气泡弹窗专用
    /// - Parameters:
    ///   - c: 内容视图
    ///   - offsetY: 垂直偏移
    /// - Returns: 半屏视图
    static public func configBubble(with c: UIView, offsetY: CGFloat) -> TGPopWindow? {
        return TGPopWindow.config(with: .bubble, c: c, nil, offsetY)
    }
    
    /// 中部弹窗专用
    /// - Parameters:
    ///   - c: 内容视图
    ///   - offsetY: 垂直偏移
    /// - Returns: 半屏视图
    static public func configCenter(with c: UIView, offsetY: CGFloat = 0) -> TGPopWindow? {
        return TGPopWindow.config(with: . center, c: c, nil, offsetY)
    }
    
    
    /// 底部弹窗(无标题)
    /// - Parameter c: 内容视图
    /// - Returns: 半屏视图
    static public func configBottomNoTitle(with c: UIView) -> TGPopWindow? {
        return TGPopWindow.config(with: .bottomNoTitle, c: c, nil)
    }
    
    
    /// 底部弹窗(带标题, 不带push功能)
    /// - Parameters:
    ///   - navTitle: 导航栏标题
    ///   - c: 内容视图
    /// - Returns: 半屏视图
    static public func configBottom(with navTitle: String, c: UIView) -> TGPopWindow? {
        return TGPopWindow.config(with: .bottomTitle, c: c, nil, navTitle: navTitle)
    }
    
    
    
    /// 底部弹窗(带导航控制器功能)
    /// - Parameter vc: 需要展示的控制器 view，导航栏标题默认跟随控制器
    /// - Returns: 半屏视图
    static public func configBottom(with vc: UIViewController?) -> TGPopWindow? {
        return TGPopWindow.config(with: .bottomTitle, c: nil, vc)
    }
    
    /// 实例化方法
    /// - Parameters:
    ///   - t: 弹窗类型
    ///   - c: 需要显示的内容视图, (在需要导航栏 push 功能时, 不需要设置该值)
    ///   - vc: 设置导航栏控制器,  (在需要导航栏 push 功能时设置)
    ///   - offsetY: 在设置bubble, center 弹窗时的垂直偏移, 其他类型设置无效
    /// - Returns: 半屏视图
    static public func config(with t: PopType, c: UIView?, _ vc: UIViewController?, _ offsetY: CGFloat = 0, navTitle: String = "") -> TGPopWindow? {
        
        guard let v = TGBaseViewController.getCurrentVC()?.view else { return nil}
        var window:TGPopWindow?
        
        if t == .bottomTitle {
            
            let navView = TGPopScrollView.config(with: vc, contentView: c)
            if navTitle.count > 0 {
                navView.navTitle = navTitle
            }
            window = TGPopWindow(t: .bottomTitle, c: navView)
            window?.navView = navView
            window?.navView?.delegate = window!
            
        } else {
            guard let c = c else { return nil}
            window = TGPopWindow(t: t, c: c)
        }
        
        guard let window = window else { return nil }
        v.addSubview(window)
        window.frame = v.bounds
        window.offsetY = offsetY

        window.setupUI()
        return window
    }
    
    
    /// - Parameter vc: 新推入的控制器
    public func pushViewController(vc: UIViewController) {
        navView?.pushViewController(vc: vc)
    }
    
    
    public func popViewController() {
        navView?.popViewController()
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        guard let s = newSuperview else { return }
        s.bringSubviewToFront(self)
    }
    
    
    /// 展示半屏
    /// - Parameter animation: 是否动画
    public func show(with animation: Bool = true) {
        isHideWindow = false
        if !animation || type == .center { show(); return}
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: .curveEaseIn) {
            self.show()
        } completion: { finished in
        }
        
    }
    
    
    /// 退出半屏
    /// - Parameters:
    ///   - animation: 是否动画, bubble, center,设置动画无效
    ///   - removeFromSuperView: 是否移出
    @objc public func dismiss(with animation: Bool = true, removeFromSuperView:Bool = true) {
        
        if removeFromSuperView { rmFromSuperView(); return }
        if !animation { isHideWindow = true}
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5, options: .curveEaseOut) {
            let f = self.cBgView?.frame ?? .zero

            self.cBgView?.snp.remakeConstraints({
                $0.size.equalTo(f.size)
                
                switch self.type {
                    case .center,.bubble:
                        break
                    case .top:
                        $0.top.equalToSuperview().offset(-f.size.height)
                    case .bottomTitle:
                        fallthrough
                    case .bottomNoTitle:
                        $0.bottom.equalToSuperview().offset(f.size.height)
                }
            })
            
            self.layoutIfNeeded()
        } completion: { finished in
            if removeFromSuperView && finished { self.rmFromSuperView() }
            if finished { self.isHideWindow = true}
        }
    }
    
    //MARK: ====================气泡弹窗

    /// 气泡弹窗三角
    private lazy var triangleView: TriangleView = {
        let tri = TriangleView()
        tri.wi = 14; tri.hi = 7
        tri.bgColor = .white
        tri.backgroundColor = .clear
        tri.layoutIfNeeded()

        tri.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        return tri
    }()
    
    
    
    
    /// 气泡视图
    private lazy var bobbleView: UIView = {
        let w: CGFloat = 160, h: CGFloat = 8, triangleH: CGFloat = 7
        
        let v = ContentBgView(frame: CGRect(x: 0, y: 0, width: w, height: h + contentView.frame.height + triangleH))
        
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        
        v.layer.shadowColor = UIColor.tg_defaultLabel(withAlpha: 0.24).cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowRadius = 10
        
        cBgView = v
        return v
    }()
    
    private func setupBubbleView() {
        
        let margin: CGFloat = 8
        
        [bobbleView,triangleView].forEach({addSubview($0)})
        
        let triSize = CGSize(width: 14, height: 7)
        triangleView.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-28)
            $0.top.equalToSuperview().offset(offsetY)
            $0.size.equalTo(triSize)
        })
        
        bobbleView.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-margin)
            $0.top.equalTo(triangleView.snp.bottom)
            $0.width.equalTo(bobbleView.frame.width)
            $0.height.equalTo(contentView.frame.height + margin * 2)
        })
        
    }
    
    //MARK: ====================顶部弹窗

    private func setupTopView() {
        var f = contentView.frame
        let margin: CGFloat = 16
        f.size.height = max(min(f.height + margin, cMaxH), cMinH)
        f.size.width = UIScreen.main.bounds.size.width
        f.origin.y = -f.size.height
        cBgView = ContentBgView(frame: f)
    }
    
    //MARK: ====================底部弹窗 - 无标题
    private func setupBottomNoTitleView() {
        var f = contentView.frame
        let margin: CGFloat = 16
        
        contentView.frame.origin.y = margin
        contentView.frame.size.width = UIScreen.main.bounds.size.width

        f.size.height = max(min(f.height + margin, cMaxH), cMinH)
        f.size.width = UIScreen.main.bounds.size.width
        f.origin.y = UIScreen.main.bounds.size.height
        cBgView = ContentBgView(frame: f)

    }
    
    //MARK: ====================中部弹窗
    
    private func setupCenterView() {
        var f = contentView.frame
        let iMargin: CGFloat = 24//内边距
        let oMargin: CGFloat = 16//外边距
        let maxBgH: CGFloat = UIView.screnHeight() - 2 * oMargin
        let maxBgW: CGFloat = UIView.screnWidth() - oMargin * 2
        let maxContentH: CGFloat = contentView.frame.size.height + iMargin * 2
        let maxContentW: CGFloat = contentView.frame.size.width + iMargin * 2

        f.size.height = min(maxBgH, maxContentH)
        f.size.width = min(maxBgW, maxContentW)
        contentView.frame.origin = CGPoint(x: iMargin, y: iMargin)
        contentView.frame.size.width = min(f.size.width - 2 * iMargin , contentView.frame.size.width)

        cBgView = ContentBgView(frame: f)
    }
    
    //MARK: ====================底部弹窗 - 有标题

    private var navView: TGPopScrollView?
    
    private func setupBottomTitleView() {
        
        guard let nav = navView else {return}
        let margin: CGFloat = 8
        nav.frame.origin.y = margin
        contentView = nav
        cBgView = ContentBgView(frame: CGRect(x: 0, y: UIView.screnHeight(), width: UIView.screnWidth(), height: cMaxH))
    }
    
    
    
    
    //MARK: ====================私有方法
    
    private func setupUI() {
        if let d = delegate {
            d.popWindowSetupUI()
            d.popWindowUpdateConstrains()
            return
        }
                
        switch type {
            case .bubble:
                setupBubbleView()
            case .top:
                setupTopView()
            case .bottomNoTitle:
                setupBottomNoTitleView()
            case .bottomTitle:
                setupBottomTitleView()
            case .center:
                setupCenterView()
        }
        
        
        if let b = cBgView {
            b.addSubview(contentView)
            addSubview(b)
            setCorner()
            backgroundColor = bgColor
            
            if type == .bubble {//特殊处理气泡弹窗布局
                contentView.snp.makeConstraints({
                    $0.top.equalToSuperview().offset(8)
                    $0.bottom.equalToSuperview().offset(-8)
                    $0.left.equalToSuperview()
                    $0.right.equalToSuperview()
                })
            }
        }
    }
    
    @objc private func rmFromSuperView() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
    private func show() {
        
        let f = cBgView?.frame ?? .zero
        self.cBgView?.snp.remakeConstraints({
            $0.size.equalTo(f.size)
            
            switch self.type {
                case .top:
                    $0.top.left.right.equalToSuperview()

                case .bubble:
                    break
                case .bottomTitle:
                    fallthrough
                case .bottomNoTitle:
                    $0.left.bottom.right.equalToSuperview()
                    
                case .center:
                    $0.centerX.equalToSuperview()
                    $0.centerY.equalToSuperview().offset(offsetY)
            }
            
        })
        
        self.layoutIfNeeded()
    }
    
    private func setCorner(_ radius: CGFloat = 16) {
        let t = type
        guard t != .bubble else { return }
        
        var corners: UIRectCorner = [.bottomLeft, .bottomRight]
        if t == .bottomTitle || t == .bottomNoTitle {
            corners = [.topLeft, .topRight]
        } else if t == .center {
            corners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        }
        
        let r = self.cBgView?.bounds ?? contentView.bounds
        
        
        let p = UIBezierPath(roundedRect: r, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let l = CAShapeLayer()
        l.path = p.cgPath
        cBgView?.layer.mask = l
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = (touches as NSSet).anyObject() as? UITouch else { return }
        let current = touch.location(in: cBgView)
        if cBgView?.point(inside: current, with: event) ?? false {
            
        } else {
            if bgUserInteraction {
                OnBackground()
            }
        }
    }
    
    deinit {
        print("TGPonWindow - dealloc")
    }
}


extension TGPopWindow: TGNavigationViewDelegate {
    
    public func dismissButtonDidClick() {
        dismiss(with: true, removeFromSuperView: false)
        delegate?.popViewDismissButtonDidClick()
    }
    
    public func gobackButtonDidClick() {
        popViewController()
        delegate?.popViewGobackButtonDidClick()
    }
}


class ContentBgView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if self.point(inside: point, with: event) {
//            var hitView:UIView?
//            subviews.forEach({
//                let p = $0.convert(point, from: self)
//                hitView = $0.hitTest(p, with: event)
//            })
//
//            return hitView
//        }
//        return super.hitTest(point, with: event)
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
