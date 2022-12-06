import Foundation

protocol SettingsDataProviderProtocol {
    func getFolderOrder() -> FolderOrderEnum?
    func setFolderOrder(_ value: FolderOrderEnum)
}
