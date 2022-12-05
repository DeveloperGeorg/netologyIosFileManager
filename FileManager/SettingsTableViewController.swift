import UIKit
import KeychainAccess

class SettingsTableViewController: UITableViewController {
    
    let keychain = Keychain()
    @IBAction func chooseOrder(_ sender: Any) {
        let controller : SettingsOrderPickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsOrderPickerViewController") as! SettingsOrderPickerViewController
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = .overCurrentContext
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func changePassword(_ sender: Any) {
        keychain["password"] = nil
        let controller : LogInViewController = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
