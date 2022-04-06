//
//  IconFont.swift
//  TGToolsKit
//
//  Created by 杨佩 on 2022/3/18.
//

import Foundation
//常用图标-效果如下
//https://sm.ms/image/SPZuMweARjWznrb
@objcMembers
public class IconFont: NSObject {
    
    public static let 编辑 = "\u{e65d}"
    public static let 点赞 = "\u{e65f}"
    public static let 定位 = "\u{e660}"
    public static let 复制 = "\u{e661}"
    public static let 关联 = "\u{e662}"
    public static let 关系图谱 = "\u{e663}"
    public static let 联系人 = "\u{e664}"
    public static let 类型 = "\u{e665}"
    public static let 股权穿透 = "\u{e666}"
    public static let 分享 = "\u{e667}"
    public static let 时间 = "\u{e668}"
    public static let 图片 = "\u{e669}"
    public static let 学校 = "\u{e66a}"
    public static let 筛选 = "\u{e66b}"
    public static let 排序 = "\u{e66c}"
    public static let 列表 = "\u{e66d}"
    public static let 选择 = "\u{e66e}"
    public static let 语音 = "\u{e66f}"
    public static let 人脉 = "\u{e670}"
    public static let 商机 = "\u{e671}"
    public static let 切换 = "\u{e672}"
    public static let 删除 = "\u{e673}"
    public static let 目录 = "\u{e674}"
    public static let 人脉洞察 = "\u{e675}"
    public static let 问号 = "\u{e676}"
    public static let 提醒时间 = "\u{e677}"
    public static let 最近通话 = "\u{e678}"
    public static let 企业 = "\u{e679}"
    public static let 地图 = "\u{e67a}"
    public static let 地址 = "\u{e67b}"
    public static let 减去 = "\u{e67c}"
    public static let 警告 = "\u{e67d}"
    public static let 清空 = "\u{e67e}"
    public static let 电话 = "\u{e67f}"
    public static let 交通 = "\u{e680}"
    public static let 添加 = "\u{e681}"
    public static let 邮箱 = "\u{e682}"
    public static let 删除图片 = "\u{e683}"
    public static let 通知 = "\u{e684}"
    public static let 更多 = "\u{e686}"
    public static let 关闭 = "\u{e687}"
    public static let 搜索 = "\u{e688}"
    public static let 扫一扫 = "\u{e68a}"
//    public static let 筛选 = "\u{e68b}"
    public static let 拨号盘 = "\u{e68c}"
    public static let 新增 = "\u{e68d}"
    public static let 即将掉保 = "\u{e68e}"
    public static let 待办 = "\u{e68f}"
    public static let 成交客户 = "\u{e690}"
    public static let 审批 = "\u{e691}"
    public static let 筛选_简 = "\u{e692}"
    public static let 客户公海 = "\u{e693}"
    public static let 箭头_上_fill = "\u{e694}"
    public static let 箭头_下拉_fill = "\u{e695}"
    public static let 箭头_上_line = "\u{e696}"
    public static let 箭头_下_line = "\u{e697}"
    public static let 箭头_左_line = "\u{e698}"
    public static let 箭头_右_line = "\u{e699}"
    public static let 多选_未选 = "\u{e685}"
    public static let 单选 = "\u{e69a}"
    public static let 多选_选中 = "\u{e69b}"
    public static let 新消息 = "\u{e69c}"
    public static let 手机 = "\u{e69d}"
//    public static let 邮箱 = "\u{e69e}"
    public static let 固话 = "\u{e69f}"
    public static let 警示0 = "\u{e6a0}"
    public static let 提示0 = "\u{e6a1}"
    public static let 成功0 = "\u{e6a2}"

    

}


extension UIFont {
    public static func IconFont(s: CGFloat) -> UIFont {
        return .init(name: "iconfont", size: s) ?? UIFont.systemFont(ofSize: s)
    }
}


extension UIButton {
    public func setTitleFont(t:String, s: CGFloat) {
        titleLabel?.text = t
        titleLabel?.font = .IconFont(s: s)
    }
}
