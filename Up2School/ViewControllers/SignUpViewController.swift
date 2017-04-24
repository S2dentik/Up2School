//
//  SignUpViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var invalidCredentialsLabel: UILabel!

    lazy var gr: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(endEditing))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sign Up"
        hideInvalidCredentials()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(gr)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.removeGestureRecognizer(gr)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }

    @IBAction func signUp(_ sender: Any) {
        guard let name = nameTextField.text, let surname = surnameTextField.text,
            let email = emailTextField.text, let phone = phoneTextField.text,
            let password = passwordTextField.text, areValidCredentials() else {
                showInvalidCredentials()
                UIView.animate(withDuration: 3) { self.hideInvalidCredentials() }
                return
        }
        let user = User(email: email, firstName: name, lastName: surname,
                        password: password, phoneNumber: phone)
        LoginManager.signUp(user)
        navigationController?.popViewController(animated: true)
    }

    private func areValidCredentials() -> Bool {
        return !(nameTextField.text?.isEmpty ?? true) &&
            !(surnameTextField.text?.isEmpty ?? true) &&
            !(emailTextField.text?.isEmpty ?? true) &&
            !(phoneTextField.text?.isEmpty ?? true) &&
            !(passwordTextField.text?.isEmpty ?? true) &&
            !(confirmPasswordTextField.text?.isEmpty ?? true) &&
            passwordTextField.text == confirmPasswordTextField.text
    }

    private func showInvalidCredentials() {
        invalidCredentialsLabel.layer.opacity = 1
    }

    private func hideInvalidCredentials() {
        invalidCredentialsLabel.layer.opacity = 0
    }
}
