//
//  LeaveReportViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

final class LeaveReportViewController: UIViewController {

    var student: Student?

    @IBOutlet weak var academicButton1: UIButton!
    @IBOutlet weak var academicButton2: UIButton!
    @IBOutlet weak var academicButton3: UIButton!
    @IBOutlet weak var academicButton4: UIButton!
    @IBOutlet weak var academicButton5: UIButton!
    @IBOutlet weak var emotionalRating1: UIButton!
    @IBOutlet weak var emotionalRating2: UIButton!
    @IBOutlet weak var emotionalRating3: UIButton!
    @IBOutlet weak var emotionalRating4: UIButton!
    @IBOutlet weak var emotionalRating5: UIButton!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!

    var emotionalRating = Rating.veryBad
    var academicRating = Rating.veryBad

    var emotionalRatingButtons: [UIButton] {
        return [emotionalRating1, emotionalRating2, emotionalRating3, emotionalRating4, emotionalRating5]
    }

    var academicRatingButtons: [UIButton] {
        return [academicButton1, academicButton2, academicButton3, academicButton4, academicButton5]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = student?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }

    @IBAction func ratingButtonPressed(_ sender: UIButton) {
        guard let id = sender.accessibilityIdentifier else { return }
        if id.hasPrefix("emotional"), let rating = id.characters.last.flatMap({ Int(String($0)) }) {
            for (i, button) in emotionalRatingButtons.enumerated() {
                button.setImage(i < rating ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart_empty"), for: .normal)
            }
            emotionalRating = Rating(rawValue: rating) ?? emotionalRating
        } else if id.hasPrefix("academic"), let rating = id.characters.last.flatMap({ Int(String($0)) }) {
            for (i, button) in academicRatingButtons.enumerated() {
                button.setImage(i < rating ? #imageLiteral(resourceName: "academic_filled") : #imageLiteral(resourceName: "academic_empty"), for: .normal)
            }
            academicRating = Rating(rawValue: rating) ?? academicRating
        }
    }

    // MARK: - Private

    @objc private func save() {
        let report = Report(academicRating: academicRating, emotionalRating: emotionalRating,
                            comment: commentTextField.text ?? "", date: datePicker.date)
        let schools = Database.schools
        for school in schools {
            for someClass in school.classes {
                for student in someClass.students {
                    if student == self.student! {
                        student.reports += [report]
                    }
                }
            }
        }
        Database.schools = schools
        navigationController?.popViewController(animated: true)
    }
}
