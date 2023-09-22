//
//  Constants.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import UIKit

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

enum Colors {
    static let bgColor = UIColor.rgb(r: 3, g: 12, b: 30)
    static let rectViewColor = UIColor.rgb(r: 38, g: 42, b: 56)
    static let textGreenColor = UIColor.rgb(r: 72, g: 198, b: 12)
    static let textLightGrayColor = UIColor.rgb(r: 177, g: 181, b: 187)
    static let textGrayColor = UIColor.rgb(r: 140, g: 145, b: 151)
}

