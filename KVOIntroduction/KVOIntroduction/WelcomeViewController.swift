import UIKit

class WelcomeViewController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var welcomeLabel: UILabel!
    
    // MARK:- Internal Variables
    
    var fontSizeObservation: NSKeyValueObservation?
    var iconNameObservation: NSKeyValueObservation?
    
    var settings = Settings.shared
    
    // MARK:- Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
    }
    
    // MARK:- Private Methods
    
    private func configureObservers() {
        observeFontSize()
        observeIconName()
    }
    
    private func observeFontSize() {
        fontSizeObservation = settings.observe(\.fontSize, options: [.old, .new]) { [weak self] object, change in
            guard let newSize = change.newValue else { return }
            self?.welcomeLabel.font = self?.welcomeLabel.font.withSize(CGFloat(newSize))
        }
    }
    private func observeIconName() {
        iconNameObservation = settings.observe(\.iconName, options: [.old, .new]) { [weak self] object, change in
            guard let newName = change.newValue,
                let newImage = UIImage(systemName: newName) else {
                    return
            }
            self?.imageView.image = newImage
        }
    }
}

