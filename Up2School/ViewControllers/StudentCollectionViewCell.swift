//
//  StudentCollectionViewCell.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    private var student: Student?

    func configureWithStudent(_ student: Student) {
        self.student = student
        nameLabel.text = student.name
    }
}
