//
//  SHGradientColorView.swift
//  SHGradientColorView
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

enum SHGradientDirection {
    case horizontal
    case vertical
}

class SHGradientColorView: UIView {
    
    var startColor: UIColor {
        didSet {
            self.setNeedsLayout()
        }
    }
    var endColor: UIColor {
        didSet {
            self.setNeedsLayout()
        }
    }
    var direction: SHGradientDirection {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private var backgroundImageView: UIImageView

    // MARK: Designated initializer
    init(frame: CGRect, startColor: UIColor, endColor: UIColor, direction: SHGradientDirection) {
        self.startColor = startColor
        self.endColor = endColor
        self.direction = direction
        self.backgroundImageView = UIImageView(frame: CGRectZero)
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.backgroundImageView)
    }

    required init(coder aDecoder: NSCoder) {
        self.startColor = UIColor.clearColor()
        self.endColor = UIColor.clearColor()
        self.direction = SHGradientDirection.horizontal
        self.backgroundImageView = UIImageView(frame: CGRectZero)
        
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(self.backgroundImageView)
    }
    
    // MARK: Layouts
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundImageView.frame = self.bounds
        self.renderImageInBackgroundForRect(self.backgroundImageView.frame)
    }

    // MARK: Create gradient
    func createGradient() -> CGGradientRef {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors: CFArray = [self.startColor.CGColor, self.endColor.CGColor]
        let locations: [CGFloat] = [0.0, 1.0]
        
        return CGGradientCreateWithColors(colorSpace, colors, locations)
    }
    
    // MARK: Draw gradient
    func drawGradientInContext(context: CGContextRef, forRect rect: CGRect) {
        CGContextSaveGState(context)
        let gradient = self.createGradient()
        let range = self.rangeToDrawInRect(rect)
        CGContextDrawLinearGradient(context, gradient, range.start, range.end, 0)
        CGContextRestoreGState(context)
    }
    
    // MARK: Draw range
    func rangeToDrawInRect(rect: CGRect) -> (start: CGPoint, end: CGPoint) {
        var start = CGPointZero
        var end = CGPointZero
        switch self.direction {
        case .horizontal:
            start = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect))
            end = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect))
        case .vertical:
            start = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect))
            end = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect))
        }
        
        return (start, end)
    }
    
    // Render image
    func renderImageInBackgroundForRect(rect: CGRect) {
        NSOperationQueue().addOperationWithBlock { () -> Void in
            UIGraphicsBeginImageContext(rect.size)
            let context = UIGraphicsGetCurrentContext()
            self.drawGradientInContext(context, forRect: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.backgroundImageView.image = image
            })
        }
    }
    
}
