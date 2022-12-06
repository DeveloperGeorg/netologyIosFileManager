import Foundation

class UserDefaultsSettingsDataProvider: SettingsDataProviderProtocol {
    let defaults = UserDefaults.standard
    
    func getFolderOrder() -> FolderOrderEnum? {
        var order: FolderOrderEnum? = nil
        if let savedValue = defaults.string(forKey: "tableOrder") {
            order = FolderOrderEnum(rawValue: savedValue)
            
        }
        return order
    }
    
    func setFolderOrder(_ value: FolderOrderEnum) {
        defaults.set(value.rawValue, forKey: "tableOrder")
    }
}
