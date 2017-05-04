import UIKit

class JFCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var backgroundBlurView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarBlurEffectView: UIVisualEffectView!

    @IBOutlet weak var readyToGrillBlurLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var readyToGrillBlurTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundLeadingContraint: NSLayoutConstraint!
    
    // MARK: - Stored Properties
    
    var plusButtonImageView: UIImageView!
    var menuButtonImageView: UIImageView!
    var animationIsToggled = false
    
    let cellHeight = CGFloat(60)
    let backgroundMotionRelativeValue = 25
    
    var menuButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPlusBarButtonItem()
        addMenuBarButtonItem()
        
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: cellHeight + 80))
        tableView.contentInset = UIEdgeInsetsMake(-cellHeight, 0, 0, 0)
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: cellHeight))
        self.tableViewLeadingConstraint.constant = self.view.frame.size.width
        self.tableViewTrailingConstraint.constant = -self.view.frame.size.width
        
        self.backgroundLeadingContraint.constant = CGFloat(-backgroundMotionRelativeValue)
        
        self.readyToGrillBlurLeadingConstraint.constant = 0
        self.readyToGrillBlurTrailingConstraint.constant = 0
            
        let verticalMotionEffect: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: UIInterpolatingMotionEffectType.tiltAlongVerticalAxis
        )
        verticalMotionEffect.minimumRelativeValue = backgroundMotionRelativeValue
        verticalMotionEffect.maximumRelativeValue = -backgroundMotionRelativeValue
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: UIInterpolatingMotionEffectType.tiltAlongHorizontalAxis
        )
        horizontalMotionEffect.minimumRelativeValue = backgroundMotionRelativeValue
        horizontalMotionEffect.maximumRelativeValue = -backgroundMotionRelativeValue
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [verticalMotionEffect, horizontalMotionEffect]
        
        backgroundView.addMotionEffect(group)
        backgroundBlurView.addMotionEffect(group)
    }
    
    // MARK: - Setup
    
    func addPlusBarButtonItem() {
        plusButtonImageView = UIImageView(image: #imageLiteral(resourceName: "plus"))
        plusButtonImageView.autoresizingMask = UIViewAutoresizing()
        plusButtonImageView.contentMode = .center
        
        let plusButton = UIButton(type: .custom)
        plusButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        plusButton.addSubview(plusButtonImageView)
        plusButton.addTarget(self, action: #selector(toggleAnimation), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: plusButton)
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func addMenuBarButtonItem() {
        menuButtonImageView = UIImageView(image: #imageLiteral(resourceName: "menu"))
        menuButtonImageView.autoresizingMask = UIViewAutoresizing()
        menuButtonImageView.contentMode = .center
        
        menuButton = UIButton(type: .custom)
        menuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        menuButton.addSubview(menuButtonImageView)
        
        let barItem = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = barItem
    }
    
    // MARK: - Actions
    
    @IBAction func toggleAnimation() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                if self.animationIsToggled {
                    
                    self.tableViewLeadingConstraint.constant = self.view.frame.size.width
                    self.tableViewTrailingConstraint.constant = -self.view.frame.size.width
                    
                    self.backgroundLeadingContraint.constant = CGFloat(-self.backgroundMotionRelativeValue)
                    
                    self.readyToGrillBlurLeadingConstraint.constant = 0
                    self.readyToGrillBlurTrailingConstraint.constant = 0
                    
                    self.backgroundBlurView.alpha = 0.0
                    self.plusButtonImageView.transform = CGAffineTransform(rotationAngle: 0.0)
                    self.navBarBlurEffectView.alpha = 0
                    
                    self.view.layoutIfNeeded()
                    
                } else {
                    self.tableViewLeadingConstraint.constant = 0
                    self.tableViewTrailingConstraint.constant = 0
                    
                    self.backgroundLeadingContraint.constant = CGFloat(-100 - self.backgroundMotionRelativeValue)
                    
                    self.readyToGrillBlurLeadingConstraint.constant = -self.view.frame.size.width
                    self.readyToGrillBlurTrailingConstraint.constant = self.view.frame.size.width

                    self.backgroundBlurView.alpha = 1.0
                    self.plusButtonImageView.transform = CGAffineTransform(rotationAngle: CGFloat(45.0 * .pi / 180.0))
                    self.navBarBlurEffectView.alpha = 1
                    self.view.layoutIfNeeded()
                }
                
            },
            completion: nil
        )
        
        self.animationIsToggled = !self.animationIsToggled
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.contentView.backgroundColor = sections[section].color
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        let nameLabel = cell.viewWithTag(100) as! UILabel
        nameLabel.text = sections[indexPath.section].items[indexPath.row].name
        
        let minutesLabel = cell.viewWithTag(101) as! UILabel
        minutesLabel.text = "\(sections[indexPath.section].items[indexPath.row].minutes) m"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let originalCell = tableView.cellForRow(at: indexPath)!
        
        // Duplicate originalCell
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: originalCell)
        let duplicateCell = NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UITableViewCell
        
        // Add duplicateCell to view at exact same place as originalCell
        let pointRelativeToWindow = originalCell.convert(self.view.frame.origin, to: nil)
        duplicateCell.frame.origin = pointRelativeToWindow
        self.view.addSubview(duplicateCell)
        
        // Animate position and opacity of both cells
        let originalAlpha = originalCell.alpha
        originalCell.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 35,
            options: [],
            animations: {
                duplicateCell.frame.origin.x -= 10
                duplicateCell.frame.size.width += 20
                duplicateCell.backgroundColor = UIColor.white
            }, completion: {
                (value: Bool) in
                
                UIView.animate(
                    withDuration: 0.35,
                    delay: 0,
                    options: UIViewAnimationOptions.curveEaseIn,
                    animations: {
                        // Replace with dynamic coords
                        duplicateCell.center.x = 33
                    }, completion: nil
                )
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0.02,
                    options: UIViewAnimationOptions.curveEaseIn,
                    animations: {
                        // Replace with dynamic coords
                        duplicateCell.center.y = 40
                        
                        duplicateCell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        duplicateCell.alpha = 0.5
                        
                        originalCell.alpha = originalAlpha
                    }, completion: {
                        (value: Bool) in
                        
                        duplicateCell.removeFromSuperview()
                        
                        self.menuButtonImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        
                        UIView.animate(
                            withDuration: 1.0,
                            delay: 0,
                            usingSpringWithDamping: 0.3,
                            initialSpringVelocity: 200,
                            options: [],
                            animations: {
                                self.menuButtonImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            }, completion: nil
                        )
                    }
                )
            }
        )
    }
}
