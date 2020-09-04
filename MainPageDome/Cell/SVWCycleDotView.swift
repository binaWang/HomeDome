//
//  CustomPageControl.swift
//  CustomCycleScrollView
//
//  Created by 王斌 on 2020/6/8.
//  Copyright © 2020 SVW. All rights reserved.
//

import UIKit
import SDCycleScrollView

class SVWCycleDotView: TADotView {
    var selectColor : UIColor? = UIColor(hexString: "#00B0F0")
    
    var normalColor: UIColor? = UIColor(hexString: "#C2CACF")
    var animateDuration:TimeInterval = 1
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = normalColor
        self.layer.borderWidth = 0
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(INIT_CODER_NIL_WARRNING)
    }
    override func changeActivityState(_ active: Bool) {
        if active{
            animate { [weak self] in
                self?.activeState()
            }
        }else{
            animate { [weak self] in
                self?.deactiveState()
            }
        }
        
    }
    private func deactiveState(){
        self.backgroundColor = self.normalColor
        self.transform = CGAffineTransform.identity;
    }
    private func activeState(){
        self.backgroundColor = self.selectColor
        self.transform = CGAffineTransform(scaleX: 2, y: 2);
    }
     private func animate( animations: @escaping () -> Void){
        UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: -20, options: .curveLinear, animations: {
            animations()
        }, completion: nil)
    }


}
