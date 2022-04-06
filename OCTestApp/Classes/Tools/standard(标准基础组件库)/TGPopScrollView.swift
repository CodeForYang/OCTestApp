//
//  TGPopViewController.swift
//  SwiftApp
//
//  Created by 杨佩 on 2022/3/31.
//

import UIKit

@objcMembers
public class TGPopScrollView: UIView, UIScrollViewDelegate {
    
    private let margin: CGFloat = 8
    private let h = UIView.screnHeight() * 0.85 - 8
    private let navH: CGFloat = 44
    private let scrollHeight: CGFloat = UIView.screnHeight() * 0.85 - 8 - 44
    private let scrollWidth: CGFloat = UIView.screnWidth()

    private var navBar: TGNavigationView

    override init(frame: CGRect) {
        navBar = TGNavigationView.config(with: "", d: nil)
        navBar.frame = CGRect(x: 0, y: 0, width: scrollWidth, height: navH)
        let f = CGRect(x: 0, y: 0, width: UIView.screnWidth(), height: h)
        super.init(frame: f)
        backgroundColor = .white
        scrollView.delegate = self
    }
    
    public var navTitle:String? {
        didSet {
            guard let t = navTitle else { return }
            navBar.update(t: t)
        }
    }
    
    public var delegate: TGNavigationViewDelegate? {
        didSet {
            navBar.delegate = delegate
        }
    }
    
    //如果有 内容视图 则只展示标题, 不处理 push 操作
    public var contentView:UIView?
    
    private lazy var scrollView: UIScrollView = {
        
        let s = UIScrollView(frame: CGRect(x: 0, y: 44, width: UIView.screnWidth(), height: scrollHeight))
        s.isUserInteractionEnabled = false
        s.isPagingEnabled = true
        s.showsVerticalScrollIndicator = false
        s.showsHorizontalScrollIndicator = false
        s.backgroundColor = .white
        s.contentSize = .zero
        return s
    }()
        
    private func updateOffsetX(with idx: Int, scrollToLeft:Bool = false) {
        navBar.showGoback = viewControlles.count > 1
        if scrollToLeft && self.scrollView.contentOffset.x <= 0 { return }
        
        UIView.animate(withDuration: 0.25) {
            if scrollToLeft {
                self.scrollView.contentOffset.x -= self.scrollWidth
            } else {
                self.scrollView.contentOffset.x += self.scrollWidth
            }
        } completion: { finished in
            if finished && scrollToLeft {
                self.updateData()
            }
        }
        
        

    }
    
    private var viewControlles = [UIViewController]()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private var preVc: UIViewController?
    public func pushViewController(vc: UIViewController?) {
        guard let vc = vc else { return}
        
        
        navTitle = vc.title
        viewControlles.append(vc)
        scrollView.addSubview(vc.view)
        
        vc.view.snp.makeConstraints({
            $0.size.equalTo(scrollView.size)
            $0.top.equalToSuperview()
            
            if let v = preVc?.view {
                $0.left.equalTo(v.snp.right)
            } else {
                $0.left.equalToSuperview()
            }
        })
        
        preVc = vc
        if viewControlles.count > 1 {
            updateOffsetX(with: viewControlles.count - 1)
        }
    }
    
    public func popViewController() {
        if viewControlles.count > 0 {
            popToViewController(vc: viewControlles.last!)
        }
    }
    
    
    func updateData() {
        viewControlles.last?.view.removeFromSuperview()
        viewControlles.removeLast()
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(viewControlles.count), height: scrollHeight)
        preVc = viewControlles.last
    }
    
    private func popToViewController(vc: UIViewController) {
        viewControlles.enumerated().forEach {  i, tmp in
            if tmp == vc {
                navTitle = vc.title
                updateOffsetX(with: i, scrollToLeft: true)
            }
        }
    }
    
    
    static public func config(with vc: UIViewController?, contentView: UIView?) -> TGPopScrollView {
        let s = TGPopScrollView()
        s.contentView = contentView
        
        if let c = contentView {
            s.addSubview(s.navBar)
            var f = c.frame
            f.origin.y = s.navH
            f.size.width = UIView.screnWidth()
            c.frame = f
            s.addSubview(c)
            
            [s.navBar, c].forEach({s.addSubview($0)})
            
            c.frame = CGRect(x: 0, y: s.navH, width: UIView.screnWidth(), height: c.size.height)
        } else {
            [s.navBar, s.scrollView].forEach({s.addSubview($0)})
            s.pushViewController(vc: vc)
        }
        
        return s
    }
    

}
