//
//  SHGradientColorView.swift
//  SHGradientColorView
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

class SHGradientColorView: UIView {
    
    var startColor: UIColor
    var endColor: UIColor

    // MARK: Designated initializer
    init(frame: CGRect, startColor: UIColor, endColor: UIColor) {
        self.startColor = startColor
        self.endColor = endColor
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }

    required init(coder aDecoder: NSCoder) {
        self.startColor = UIColor.clearColor()
        self.endColor = UIColor.clearColor()
        
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: Draw rect
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.drawGradientHorizontallyInContext(context, forRect: rect)
    }

    // MARK: Create gradient
    func createGradient() -> CGGradient {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors: CFArray = [self.startColor.CGColor, self.endColor.CGColor]
        let locations: [CGFloat] = [0.0, 1.0]
        
        return CGGradientCreateWithColors(colorSpace, colors, locations)
    }
    
    // MARK: Draw gradient
    func drawGradientHorizontallyInContext(context: CGContext, forRect rect: CGRect) {
        CGContextSaveGState(context)
        
        let gradient = self.createGradient()
        let startPoint = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect))
        let endPoint = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect))
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        
        CGContextRestoreGState(context)
    }
    
}
