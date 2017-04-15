//
//  InitialViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

var userType = UserType.parent

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "I am"
    }

    @IBAction func parentButtonPressed(_ sender: Any) {
        presentLoginScreen()
        userType = .parent
    }

    @IBAction func teacherButtonPressed(_ sender: Any) {
        presentLoginScreen()
        userType = .teacher
    }


    private func presentLoginScreen() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}

