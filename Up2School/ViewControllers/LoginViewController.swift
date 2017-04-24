//
//  LoginViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidCredentialsLabel: UILabel!

    lazy var gr: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(endEditing))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sign In"
        hideInvalidCredentials()
        view.addGestureRecognizer(gr)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    @IBAction func signUp(_ sender: Any) {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "SignUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard isValidLogin() else {
            showInvalidCredentials()
            UIView.animate(withDuration: 3) { self.hideInvalidCredentials() }
            return
        }
        if userType == .parent {
            let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "SchoolPickerViewController") as! SchoolPickerViewController
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "EditClassViewController") as! EditClassViewController
            guard let user = LoginManager.instance.currentUser else { return }
            for school in Database.schools {
                for `class` in school.classes {
                    if `class`.teacher == "\(user.lastName) \(user.firstName)" {
                        viewController.currentClass = `class`
                    }
                }
            }
            navigationController?.pushViewController(viewController, animated: true)
        }

    }

    private func showInvalidCredentials() {
        invalidCredentialsLabel.layer.opacity = 1
    }

    private func hideInvalidCredentials() {
        invalidCredentialsLabel.layer.opacity = 0
    }

    private func isValidLogin() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return false }
        return LoginManager.login(email: email, password: password)
    }
}
