//
//  EditClassViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class EditClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CreateClassViewControllerDelegate {

    @IBOutlet weak var noClassLabel: UILabel!
    @IBOutlet weak var createClassButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var currentClass: Class?

    override func viewDidLoad() {
        super.viewDidLoad()

        createClassButton.isHidden = true
        noClassLabel.isHidden = true
        configureLabels()
        navigationItem.title = currentClass?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }

    @IBAction func createClass(_ sender: Any) {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "CreateClassViewController") as! CreateClassViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - CreateClassViewControllerDelegate

    func didCreateClass(_ class: Class) {
        currentClass = `class`
        collectionView.reloadData()
        configureLabels()
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentClass?.students.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell",
                                                      for: indexPath) as! StudentCollectionViewCell
        currentClass.flatMap { cell.configureWithStudent($0.students[indexPath.row]) }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LeaveReportViewController") as! LeaveReportViewController
        vc.student = currentClass?.students[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Private

    private func configureLabels() {
        if let currentClass = currentClass {
            if currentClass.students.isEmpty {
                createClassButton.isHidden = true
                noClassLabel.isHidden = false
            }
            return
        } else {
            createClassButton.isHidden = false
            noClassLabel.isHidden = true
            return
        }
    }
}
