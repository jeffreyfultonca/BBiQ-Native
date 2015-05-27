//
//  JFCViewController.swift
//  BBiQ-Native
//
//  Created by Jeffrey Fulton on 2014-12-06.
//  Copyright (c) 2014 Jeffrey Fulton. All rights reserved.
//

import UIKit

class JFCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundBlurView: UIImageView!
    var plusButtonImageView: UIImageView!
    var menuButtonImageView: UIImageView!
    var animationIsToggled = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarBlurEffectView: UIVisualEffectView!

    @IBOutlet weak var readyToGrillBlurLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var readyToGrillBlurTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundLeadingContraint: NSLayoutConstraint!
    
    let cellHeight = CGFloat(60)
    let backgroundMotionRelativeValue = 25
    
    var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPlusBarButtonItem()
        addMenuBarButtonItem()
        
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, cellHeight + 80))
        tableView.contentInset = UIEdgeInsetsMake(-cellHeight, 0, 0, 0)
        
        tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, cellHeight))
        self.tableViewLeadingConstraint.constant = self.view.frame.size.width
        self.tableViewTrailingConstraint.constant = -self.view.frame.size.width
        
        self.backgroundLeadingContraint.constant = CGFloat(-backgroundMotionRelativeValue)
        
        self.readyToGrillBlurLeadingConstraint.constant = 0
        self.readyToGrillBlurTrailingConstraint.constant = 0
            
        var verticalMotionEffect: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis
        )
        verticalMotionEffect.minimumRelativeValue = backgroundMotionRelativeValue
        verticalMotionEffect.maximumRelativeValue = -backgroundMotionRelativeValue
        
        var horizontalMotionEffect = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis
        )
        horizontalMotionEffect.minimumRelativeValue = backgroundMotionRelativeValue
        horizontalMotionEffect.maximumRelativeValue = -backgroundMotionRelativeValue
        
        var group = UIMotionEffectGroup()
        group.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        
        backgroundView.addMotionEffect(group)
        backgroundBlurView.addMotionEffect(group)
    }
    
    func addPlusBarButtonItem() {
        var image = UIImage(named: "plus")
        image = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        plusButtonImageView = UIImageView(image: image)
        plusButtonImageView.autoresizingMask = UIViewAutoresizing.None
        plusButtonImageView.contentMode = UIViewContentMode.Center
        
        var plusButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        plusButton.frame = CGRectMake(0, 0, 40, 40)
        plusButton.addSubview(plusButtonImageView)
        plusButton.addTarget(self, action: "toggleAnimation", forControlEvents: UIControlEvents.TouchUpInside)
        var barItem = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func addMenuBarButtonItem() {
        var image = UIImage(named: "menu")
        image = image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        menuButtonImageView = UIImageView(image: image)
        menuButtonImageView.autoresizingMask = UIViewAutoresizing.None
        menuButtonImageView.contentMode = UIViewContentMode.Center
        
        menuButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        menuButton.frame = CGRectMake(0, 0, 40, 40)
        menuButton.addSubview(menuButtonImageView)
        var barItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = barItem
    }
    
    @IBAction func toggleAnimation() {
    
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0,
            options: nil,
            animations: {
                if self.animationIsToggled {
                    
                    self.tableViewLeadingConstraint.constant = self.view.frame.size.width
                    self.tableViewTrailingConstraint.constant = -self.view.frame.size.width
                    
                    self.backgroundLeadingContraint.constant = CGFloat(-self.backgroundMotionRelativeValue)
                    
                    self.readyToGrillBlurLeadingConstraint.constant = 0
                    self.readyToGrillBlurTrailingConstraint.constant = 0
                    
                    self.backgroundBlurView.alpha = 0.0
                    self.plusButtonImageView.transform = CGAffineTransformMakeRotation(0.0)
                    self.navBarBlurEffectView.alpha = 0
                    
                    self.view.layoutIfNeeded()
                    
                } else {
                    self.tableViewLeadingConstraint.constant = 0
                    self.tableViewTrailingConstraint.constant = 0
                    
                    self.backgroundLeadingContraint.constant = CGFloat(-100 - self.backgroundMotionRelativeValue)
                    
                    self.readyToGrillBlurLeadingConstraint.constant = -self.view.frame.size.width
                    self.readyToGrillBlurTrailingConstraint.constant = self.view.frame.size.width

                    self.backgroundBlurView.alpha = 1.0
                    self.plusButtonImageView.transform = CGAffineTransformMakeRotation(CGFloat(45.0 * M_PI / 180.0))
                    self.navBarBlurEffectView.alpha = 1
                    self.view.layoutIfNeeded()
                }
                
            },
            completion: nil
        )
        
        self.animationIsToggled = !self.animationIsToggled
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var header = view as! UITableViewHeaderFooterView
        header.textLabel.textColor = UIColor.whiteColor()
        header.contentView.backgroundColor = sections[section].color
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    // MARK: - UITableViewDataSource
    
    struct JFCFoodItem {
        var name: String
        var minutes: Int
    }
    
    struct JFCSection {
        var name: String
        var items: Array<JFCFoodItem>
        var color: UIColor
    }
    

    
    let sections = [
        JFCSection(
            name: "Beef",
            items: [
                JFCFoodItem(name: "Burger", minutes: 12),
                JFCFoodItem(name: "Ribs", minutes: 30),
                JFCFoodItem(name: "Roast", minutes: 45),
                JFCFoodItem(name: "Steak", minutes: 12)
            ],
            color: UIColor(red: 0.777, green: 0.133, blue: 0.133, alpha: 1.0)
        ),
        JFCSection(
            name: "Chicken",
            items: [
                JFCFoodItem(name: "Breast", minutes: 10),
                JFCFoodItem(name: "Burger", minutes: 12),
                JFCFoodItem(name: "Whole", minutes: 75),
                JFCFoodItem(name: "Wings", minutes: 15)
            ],
            color: UIColor(red: 0.648, green: 0.504, blue: 0.18, alpha: 1.0)
        ),
        JFCSection(
            name: "Pork",
            items: [
                JFCFoodItem(name: "Chop", minutes: 10),
                JFCFoodItem(name: "Ribs", minutes: 32),
                JFCFoodItem(name: "Roast", minutes: 25),
                JFCFoodItem(name: "Tenderloin", minutes: 15)
            ],
            color: UIColor(red: 0.180, green: 0.627, blue: 0.651, alpha: 1.0)
        ),
        JFCSection(
            name: "Vegetables",
            items: [
                JFCFoodItem(name: "Carrots", minutes: 15),
                JFCFoodItem(name: "Corn", minutes: 18),
                JFCFoodItem(name: "Onions", minutes: 12),
                JFCFoodItem(name: "Potatoes", minutes: 30)
            ],
            color: UIColor(red: 0.369, green: 0.588, blue: 0.133, alpha: 1.0)
        )
    ]
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return sections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return sections[section].items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        var nameLabel = cell.viewWithTag(100) as! UILabel
        nameLabel.text = sections[indexPath.section].items[indexPath.row].name
        
        var minutesLabel = cell.viewWithTag(101) as! UILabel
        minutesLabel.text = "\(sections[indexPath.section].items[indexPath.row].minutes) m"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        var originalCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var originalBackgroundColor = originalCell.backgroundColor
        
        var duplicateCell = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(originalCell)) as! UITableViewCell
        
        let pointRelativeToWindow = originalCell.convertPoint(self.view.frame.origin, toView: nil)
        duplicateCell.frame.origin = pointRelativeToWindow
        self.view.addSubview(duplicateCell)
        
        let originalAlpha = originalCell.alpha
        originalCell.alpha = 0
        
        UIView.animateWithDuration(
            0.3,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 35,
            options: nil,
            animations: {
                duplicateCell.frame.origin.x -= 10
                duplicateCell.frame.size.width += 20
                duplicateCell.backgroundColor = UIColor.whiteColor()
            }, completion: {
                (value: Bool) in
                
                UIView.animateWithDuration(
                    0.35,
                    delay: 0,
                    options: UIViewAnimationOptions.CurveEaseIn,
                    animations: {
                        // Replace with dynamic coords
                        duplicateCell.center.x = 33
                    }, completion: nil
                )
                UIView.animateWithDuration(
                    0.4,
                    delay: 0.02,
                    options: UIViewAnimationOptions.CurveEaseIn,
                    animations: {
                        // Replace with dynamic coords
                        duplicateCell.center.y = 40
                        
                        duplicateCell.transform = CGAffineTransformMakeScale(0.1, 0.1)
                        duplicateCell.alpha = 0.5
                        
                        originalCell.alpha = originalAlpha
                    }, completion: {
                        (value: Bool) in
                        
                        duplicateCell.removeFromSuperview()
                        
                        self.menuButtonImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                        
                        UIView.animateWithDuration(
                            1.0,
                            delay: 0,
                            usingSpringWithDamping: 0.3,
                            initialSpringVelocity: 200,
                            options: nil,
                            animations: {
                                self.menuButtonImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                            }, completion: nil
                        )
                    }
                )
            }
        )
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
