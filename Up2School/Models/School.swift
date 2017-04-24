//
//  School.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

class School: NSObject, NSCoding, NSKeyedUnarchiverDelegate {
    let name: String
    var classes = [Class]()

    init(name: String, classes: [Class]) {
        self.name = name
        self.classes = classes
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String,
            let classes = aDecoder.decodeObject(forKey: "classes") as? [Data] else {
                return nil
        }
        self.name = name
        super.init()
        self.classes = classes.flatMap {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: $0)
            unarchiver.delegate = self
            return unarchiver.decodeObject(forKey: "root") as? Class
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(classes.map { NSKeyedArchiver.archivedData(withRootObject: $0) }, forKey: "classes")
    }

    // MARK: - NSKeyedUnarchiverDelegate

    func unarchiver(_ unarchiver: NSKeyedUnarchiver,
                    cannotDecodeObjectOfClassName name: String,
                    originalClasses classNames: [String]) -> AnyClass? {
        return Class.self
    }
}
