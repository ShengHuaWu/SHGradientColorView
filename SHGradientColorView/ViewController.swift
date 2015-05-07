//
//  ViewController.swift
//  SHGradientColorView
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gradientColorView: SHGradientColorView? = nil

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRectMake(30, 100, 300, 60)
        let gradientColorView = SHGradientColorView(frame: frame, startColor: UIColor.yellowColor(), endColor: UIColor.blueColor(), direction: SHGradientDirection.horizontal)
        self.view.addSubview(gradientColorView)
        self.gradientColorView = gradientColorView
        
        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.frame = CGRectMake(150, 200, 80, 44)
        button.setTitle("Change", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "changeColor:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    // MARK: Button action
    func changeColor(button: UIButton) {
        if let gradientView = self.gradientColorView {
//            gradientView.startColor = UIColor.redColor()
//            gradientView.endColor = UIColor.greenColor()
            gradientView.direction = SHGradientDirection.vertical
        }
    }
}

