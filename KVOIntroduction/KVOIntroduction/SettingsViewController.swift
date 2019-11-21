import UIKit

class SettingsViewController: UIViewController {
        
    // MARK:- IBOutlets
    
    @IBOutlet var iconNamePickerView: UIPickerView!
    @IBOutlet var fontSizeLabel: UILabel!
    
    // MARK:- Internal Variables
    
    var iconNames = [String]()
    var fontSizeObservation: NSKeyValueObservation?

    // MARK:- Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadIconNames()
        configurePickerView()
        configureObservers()
    }
    
    // MARK:- IBActions
    
    @IBAction func fontSizeChanged(_ slider: UISlider) {
        let newSize = Int(slider.value)
        Settings.shared.fontSize = newSize
    }
    
    // MARK:- Private Methods
    
    private func loadIconNames() {
        iconNames = ["sun.haze", "moon", "globe", "icloud"]
    }
    
    private func configurePickerView() {
        iconNamePickerView.delegate = self
        iconNamePickerView.dataSource = self
    }
    
    private func configureObservers() {
        observeFontSize()
    }
    
    private func observeFontSize() {
        fontSizeObservation = Settings.shared.observe(\.fontSize, options: [.old, .new]) { [weak self] object, change in
            guard let newSize = change.newValue else { return }
            self?.fontSizeLabel.text = "\(newSize)"
        }
    }
}

// MARK:- UIPickerViewDelegate

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return iconNames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let iconName = iconNames[row]
        Settings.shared.iconName = iconName
    }
}

// MARK:- UIPickerViewDataSource

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return iconNames.count
    }
}
