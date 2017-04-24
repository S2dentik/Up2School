//
//  SchoolPickerViewController.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import UIKit

class SchoolPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var schoolPickerView: UIPickerView!
    @IBOutlet weak var classPickerView: UIPickerView!
    @IBOutlet weak var studentPickerView: UIPickerView!

    var pageViewController: UIPageViewController!

    var schoolIndex: Int {
        return schoolPickerView.selectedRow(inComponent: 0)
    }

    var classIndex: Int {
        return classPickerView.selectedRow(inComponent: 0)
    }

    var studentIndex: Int {
        return studentPickerView.selectedRow(inComponent: 0)
    }

    var student: Student {
        return Database.schools[schoolIndex].classes[classIndex].students[studentIndex]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self, action: #selector(presentReportScreen))
    }

    func presentReportScreen() {
        pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([viewControllerAtIndex(0)],
                                              direction: .forward, animated: true, completion: nil)
        pageViewController.navigationItem.title = student.name
        navigationController?.pushViewController(pageViewController, animated: true)
    }

    func viewControllerAtIndex(_ index: Int) -> UIViewController {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        vc.report = student.reports[index]
        vc.pageIndex = index

        return vc
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let schools = Database.schools
        if pickerView === schoolPickerView {
            return schools.count
        } else if pickerView === classPickerView {
            return schools[schoolIndex].classes.count
        } else {
            let index = classIndex
            if index >= schools[schoolIndex].classes.count { return 0 }
            return schools[schoolIndex].classes[index].students.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let schools = Database.schools
        if pickerView === schoolPickerView {
            return schools[row].name
        } else if pickerView === classPickerView {
            return schools[schoolIndex].classes[row].name
        } else {
            return schools[schoolIndex].classes[classIndex].students[row].name
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        schoolPickerView.reloadAllComponents()
        classPickerView.reloadAllComponents()
        studentPickerView.reloadAllComponents()
    }
}

extension SchoolPickerViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return student.reports.count
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let previousIndex = (viewController as! ReportViewController).pageIndex - 1
        guard previousIndex >= 0 else { return nil }
        return viewControllerAtIndex(previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = (viewController as! ReportViewController).pageIndex + 1
        guard nextIndex < student.reports.count else { return nil }
        return viewControllerAtIndex(nextIndex)
    }
}
