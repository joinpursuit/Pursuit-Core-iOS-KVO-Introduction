import UIKit

@objc class Settings: NSObject {
    static let shared = Settings()
    override private init() {
        self.fontSize = 15
        self.iconName = "sun.haze"
    }
    @objc dynamic var fontSize: Int
    @objc dynamic var iconName: String
}
