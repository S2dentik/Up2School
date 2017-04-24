//
//  Class.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

class Class: NSObject, NSCoding, NSKeyedUnarchiverDelegate {
    let name: String
    let teacher: String
    var students = [Student]()

    init(name: String, teacher: String, students: [Student]) {
        self.name = name
        self.teacher = teacher
        self.students = students
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let teacher = aDecoder.decodeObject(forKey: "teacher") as? String,
            let students = aDecoder.decodeObject(forKey: "students") as? [Data] else {
                return nil
        }
        self.name = name
        self.teacher = teacher
        super.init()
        self.students = students.flatMap {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: $0)
            unarchiver.delegate = self
            return unarchiver.decodeObject(forKey: "root") as? Student
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(teacher, forKey: "teacher")
        aCoder.encode(students.map { NSKeyedArchiver.archivedData(withRootObject: $0) }, forKey: "students")
    }

    // MARK: - NSKeyedUnarchiverDelegate

    func unarchiver(_ unarchiver: NSKeyedUnarchiver,
                    cannotDecodeObjectOfClassName name: String,
                    originalClasses classNames: [String]) -> AnyClass? {
        return Student.self
    }
}
