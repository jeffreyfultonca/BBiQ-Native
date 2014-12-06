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
    var plusButtonImageView: UIImageView!;
    var animationIsToggled = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPlusBarButtonItem()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.frame.origin.x += view.frame.size.width
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
    
    func createTableView() {
        
    }
    
    func toggleAnimation() {
        createTableView()
        
        UIView.animateWithDuration(0.5, animations: {
            if self.animationIsToggled {
                self.tableView.frame.origin.x += self.view.frame.size.width
                self.blurView.frame.origin.x = 0
                self.backgroundView.frame.origin.x = 0
                self.backgroundBlurView.frame.origin.x = 0
                self.backgroundBlurView.alpha = 0.0
                self.plusButtonImageView.transform = CGAffineTransformMakeRotation(0.0)
            } else {
                self.tableView.frame.origin.x -= self.view.frame.size.width
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
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        var header = view as UITableViewHeaderFooterView
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
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        var nameLabel = cell.viewWithTag(100) as UILabel
        nameLabel.text = sections[indexPath.section].items[indexPath.row].name
        
        var minutesLabel = cell.viewWithTag(101) as UILabel
        minutesLabel.text = "\(sections[indexPath.section].items[indexPath.row].minutes) m"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row: \(indexPath.row) in section: \(indexPath.section)")
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
