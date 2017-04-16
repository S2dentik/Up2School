//
//  EditClassViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class EditClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var noClassLabel: UILabel!
    @IBOutlet weak var createClassButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    var `class`: Class?

    override func viewDidLoad() {
        super.viewDidLoad()

        createClassButton.isHidden = true
        noClassLabel.isHidden = true
        configureLabels()
        navigationItem.title = self.class?.name
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.class?.students.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell",
                                                      for: indexPath) as! StudentCollectionViewCell
        cell.nameLabel.text = self.class?.students[indexPath.row].name

        return cell
    }

    // MARK: - Private

    private func configureLabels() {
        if let currentClass = self.class {
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
