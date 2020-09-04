//
//  HomeScrollView.swift
//  MainPageDome
//
//  Created by Wang, bin on 2020/9/2.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

class HomeScrollView: PageMenuScrollView ,UIGestureRecognizerDelegate{
    var pageMenu:PageMenu?
    var cycleView:SVWCycleView?

    var contentOffsetY : CGFloat = 10000
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        if self.contentOffset.y < contentOffsetY{
//            return self
//        }else{
//            let view = super.hitTest(point, with: event)
//            print("手势 是 \(view)")
//            return view
//
//        }
////        return super.hitTest(point, with: event)
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
//
//        if let pan = gestureRecognizer as? UIPanGestureRecognizer,pan.state == .changed{
//            let translation = pan.translation(in: self.pageMenu!.view)
//            let absX = fabsf(Float(translation.x))
//            let absY = fabsf(Float(translation.y))
//            if absY > absX{
//                if translation.y < 0 {
//                    // 上
//                    
//                }else{
//                    // 下
//                }
//            }
//
//        }
//        print(gestureRecognizer.isKind(of:  UIPanGestureRecognizer.self))
//
//        return true
//
//    }


}
