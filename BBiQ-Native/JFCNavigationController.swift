//
//  JFCNavigationController.swift
//  BBiQ-Native
//
//  Created by Jeffrey Fulton on 2014-12-05.
//  Copyright (c) 2014 Jeffrey Fulton. All rights reserved.
//

import UIKit

class JFCNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)

        // Draw bottom border
        var border = CALayer()
        border.borderColor = UIColor.whiteColor().CGColor
        border.borderWidth = 1;
        var layer = self.navigationBar.layer
        border.frame = CGRectMake(
            0,
            layer.bounds.size.height,
            layer.bounds.size.width,
            1
        )
        layer.addSublayer(border)
        
        // Used to find custom font names - remove when done
//        for family in UIFont.familyNames() {
//            println("family: \(family)")
//            
//            for name in UIFont.fontNamesForFamilyName(family.description) {
//                println(name)
//            }
//        }
        
        var attributes = [
            NSFontAttributeName: UIFont(name: "MyriadPro-Regular", size: 24)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
        
        self.navigationBar.titleTextAttributes = attributes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
