import UIKit
import KeychainAccess

class LogInViewController: UIViewController {
    
    private var firstTimeSetPassword: String?
    let keychain = Keychain()

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var enterPasswordButton: UIButton!
    
    @IBOutlet weak var setPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.initializeViewElements()
    }

    private func initializeViewElements() -> Void {
        if (self.checkPasswordWasSet()) {
            enterPasswordButton.setTitle("Введите пароль", for: .normal)
            setPasswordButton.isHidden = true
        } else {
            setPasswordButton.setTitle("Создать пароль", for: .normal)
            enterPasswordButton.isHidden = true
        }
    }

    @IBAction func setPasswordHandler(_ sender: Any) {
        guard let passwordFromInput = passwordField.text else { return  }
        if (validatePassword(password: passwordFromInput)) {
            if (self.firstTimeSetPassword == nil) {
                self.firstTimeSetPassword = passwordFromInput
                setPasswordButton.setTitle("Повторите пароль", for: .normal)
                passwordField.text = ""
            } else {
                if (self.firstTimeSetPassword == passwordFromInput) {
                    self.firstTimeSetPassword = nil
                    self.setPassword(password: passwordFromInput)
                    goToTheApp()
                } else {
                    self.firstTimeSetPassword = nil
                    passwordField.text = ""
                    self.initializeViewElements()
                    showError("Пароли не совпадают")
                }
            }
        }
    }
    
    @IBAction func enterPasswordHandler(_ sender: Any) {
        guard let passwordFromInput = passwordField.text else { return }
        if (self.checkPassword(password: passwordFromInput)) {

            goToTheApp()
            return
        }
    }
    
    private func checkPasswordWasSet() -> Bool {
        return self.getPassword() != nil
    }

    private func checkPassword(password: String) -> Bool {
        if (password != self.getPassword()) {
            showError("Неверный пароль")
            return false
        }
        return true
    }

    private func getPassword() -> String? {
        return keychain["password"]
    }

    private func setPassword(password: String) -> Void {
        keychain["password"] = password
    }

    private func validatePassword(password: String) -> Bool {
        if (password.count < 4) {
            showError("Пароль должен содержать минимум 4 сивола")
            return false
        }
        return true
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func goToTheApp() -> Void {
        let controller : UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "AppTabBar") as! UITabBarController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
