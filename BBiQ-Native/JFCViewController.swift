//
//  JFCViewController.swift
//  BBiQ-Native
//
//  Created by Jeffrey Fulton on 2014-12-06.
//  Copyright (c) 2014 Jeffrey Fulton. All rights reserved.
//

import UIKit

class JFCViewController: UIViewController {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundBlurView: UIImageView!
    var plusButtonImageView: UIImageView!;
    var animationIsToggled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPlusBarButtonItem()
    }
    
    func addPlusBarButtonItem() {
        var image = UIImage(named: "plus")
        image = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        plusButtonImageView = UIImageView(image: image)
        plusButtonImageView.autoresizingMask = UIViewAutoresizing.None
        plusButtonImageView.contentMode = UIViewContentMode.Center
        
        var plusButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        plusButton.frame = CGRectMake(0, 0, 40, 40)
        plusButton.addSubview(plusButtonImageView)
        plusButton.addTarget(self, action: "toggleAnimation", forControlEvents: UIControlEvents.TouchUpInside)
        plusButtonImageView.center = plusButton.center
        var barItem = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func toggleAnimation() {
        UIView.animateWithDuration(0.5, animations: {
            if self.animationIsToggled {
                self.blurView.frame.origin.x = 0
                self.backgroundView.frame.origin.x = 0
                self.backgroundBlurView.frame.origin.x = 0
                self.backgroundBlurView.alpha = 0.0
                self.plusButtonImageView.transform = CGAffineTransformMakeRotation(0.0)
            } else {
                self.blurView.frame.origin.x -= self.blurView.frame.size.width
                self.backgroundView.frame.origin.x -= 100
                self.backgroundBlurView.frame.origin.x -= 100
                self.backgroundBlurView.alpha = 1.0
                self.plusButtonImageView.transform = CGAffineTransformMakeRotation(CGFloat(45.0 * M_PI / 180.0))
            }
            self.animationIsToggled = !self.animationIsToggled
        })
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
