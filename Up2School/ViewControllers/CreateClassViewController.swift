//
//  CreateClassViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/22/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

protocol CreateClassViewControllerDelegate: class {
    func didCreateClass(_ class: Class)
}

class CreateClassViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var schoolPickerView: UIPickerView!
    @IBOutlet weak var classTextField: UITextField!

    weak var delegate: CreateClassViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create Class"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }

    @objc private func save() {
        let schoolIndex = schoolPickerView.selectedRow(inComponent: 0)
        guard let className = classTextField.text, !className.isEmpty,
            let user = LoginManager.instance.currentUser else { return }

        let teacher = "\(user.lastName) \(user.firstName)"
        let newClass = Class(name: className.uppercased(), teacher: teacher, students: [])
        let oldSchool = Database.schools[schoolIndex]
        let classes = oldSchool.classes + [newClass]
        let school = School(name: oldSchool.name, classes: classes)
        var schools = Database.schools
        schools[schoolIndex] = school
        delegate?.didCreateClass(newClass)
        Database.schools = schools
        navigationController?.popViewController(animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Database.schools.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Database.schools[row].name
    }
}
