//
//  String+Extension.swift
//  DomeConfig
//
//  Created by Wang, bin on 2020/8/20.
//  Copyright © 2020 Wang, bin. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }


extension Character {
    static func arbitraryChinese() -> Character {
        let random = UInt32.random(in: 0x4E00...0x9FA5)
        return Character(UnicodeScalar(random)!)
    }
    static func arbitraryEnglishCapital() -> Character {
        let random = UInt32.random(in: 0x41...0x5A)
        return Character(UnicodeScalar(random)!)
    }
    static func arbitraryEnglishLowercasel() -> Character {
        let random = UInt32.random(in: 0x61...0x7A)
        return Character(UnicodeScalar(random)!)
    }
}

extension String {
    static func arbitrary(length:Int ,charBlock:(Int)->(Character))->String {
        let char = (0..<length).map{index in
            charBlock(index)
        }
        return  String(char)
    }
    
}
