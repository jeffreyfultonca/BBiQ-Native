import UIKit

class JFCNavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        // Draw bottom border
        let border = CALayer()
        border.borderColor = UIColor.white.cgColor
        border.borderWidth = 1;
        let layer = self.navigationBar.layer
        border.frame = CGRect(
            x: 0,
            y: layer.bounds.size.height,
            width: layer.bounds.size.width,
            height: 1
        )
        layer.addSublayer(border)
        
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "MyriadPro-Regular", size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        self.navigationBar.titleTextAttributes = attributes
    }
}
