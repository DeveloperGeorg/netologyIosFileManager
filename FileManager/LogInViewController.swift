//
//  LogInViewController.swift
//  FileManager
//
//  Created by Георгий Бондаренко on 03.12.2022.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var enterPasswordButton: UIButton!
    
    @IBOutlet weak var setPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.checkPasswordWasSet()) {
            enterPasswordButton.setTitle("Введите пароль", for: .normal)
            setPasswordButton.isHidden = true
        } else {
            setPasswordButton.setTitle("Создать пароль", for: .normal)
            enterPasswordButton.isHidden = true
        }
    }

    @IBAction func setPasswordHandler(_ sender: Any) {
    }
    
    @IBSegueAction func enterPasswordHandler(_ coder: NSCoder) -> FolderViewController? {
        guard let passwordFromInput = passwordField.text else { return nil }
        print(passwordFromInput)
        if (self.checkPassword(password: passwordFromInput)) {
            
            return FolderViewController(coder: coder)
        } else {
            /**@todo error */
            return nil
        }
    }
    
    private func checkPasswordWasSet() -> Bool {
        return true
    }

    private func checkPassword(password: String) -> Bool {
        return password == "test"
    }
}
