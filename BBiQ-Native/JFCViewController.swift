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
    
    
    let sections = [
        "Beef": [
            [ "name": "Burger", "minutes": 12],
            [ "name": "Ribs", "minutes": 30],
            [ "name": "Roast", "minutes": 45],
            [ "name": "Steak", "minutes": 12]
        ],
        "Chicken": [
            [ "name": "Breast", "minutes": 10],
            [ "name": "Burger", "minutes": 12],
            [ "name": "Whole", "minutes": 75],
            [ "name": "Wings", "minutes": 15]
        ]
    ]
    
    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        println("sections count: \(sections.count)")
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        cell.textLabel.text = "test"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
