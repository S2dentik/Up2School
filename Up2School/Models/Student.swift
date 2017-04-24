//
//  Student.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

class Student: NSObject, NSCoding, NSKeyedUnarchiverDelegate {
    let name: String
    var reports = [Report]()

    init(name: String, reports: [Report]) {
        if name == "Rusu Francesca" {
            print("")
        }
        self.name = name
        self.reports = reports
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let reports = aDecoder.decodeObject(forKey: "reports") as? [Data] else {
                return nil
        }
        self.name = name
        super.init()
        self.reports = reports.flatMap {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: $0)
            unarchiver.delegate = self
            return unarchiver.decodeObject(forKey: "root") as? Report
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(reports.map { NSKeyedArchiver.archivedData(withRootObject: $0) }, forKey: "reports")
    }

    // MARK: - NSKeyedUnarchiverDelegate

    func unarchiver(_ unarchiver: NSKeyedUnarchiver,
                    cannotDecodeObjectOfClassName name: String,
                    originalClasses classNames: [String]) -> AnyClass? {
        return Report.self
    }
}

extension Student {
    convenience init(name: String) {
        self.init(name: name, reports: [])
    }
}

func == (lhs: Student, rhs: Student) -> Bool {
    return lhs.name == rhs.name
}
