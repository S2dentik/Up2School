//
//  LoginViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var type = UserType.teacher

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sign In"
    }

    @IBAction func signUp(_ sender: Any) {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "SignUpViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func signIn(_ sender: Any) {
        let viewController = UIStoryboard.main.instantiateViewController(withIdentifier: "SchoolPickerViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
