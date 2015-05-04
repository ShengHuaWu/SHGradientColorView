//
//  ViewController.swift
//  SHGradientColorView
//
//  Created by WuShengHua on 5/4/15.
//  Copyright (c) 2015 ShengHuaWu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        let frame = CGRectMake(10, 100, 300, 60)
        let gradientColorView = SHGradientColorView(frame: frame, startColor: UIColor.yellowColor(), endColor: UIColor.blueColor())
        self.view.addSubview(gradientColorView)
    }
    
}

