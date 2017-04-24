//
//  Database.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

final class Database: NSObject, NSKeyedUnarchiverDelegate {

    private let defaults = UserDefaults.standard

    static let instance = Database()
    private override init() { super.init() }

    private var wasInitialDataPopulated: Bool {
        get {
            return defaults.bool(forKey: "initialDataPopulated")
        } set {
            defaults.set(newValue, forKey: "initialDataPopulated")
        }
    }

    static var schools: [School] {
        get {
            return instance.schools
        } set {
            instance.schools = newValue
        }
    }

    var schools: [School] {
        get {
            if !wasInitialDataPopulated {
                self.schools = initialSchools
                wasInitialDataPopulated = true
            }
            let datas = defaults.array(forKey: "schools") as? [Data] ?? []
            return datas.flatMap { data in
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                unarchiver.delegate = self
                return unarchiver.decodeObject(forKey: "root") as? School
            }
        } set {
            let schools = newValue.map { NSKeyedArchiver.archivedData(withRootObject: $0) }
            defaults.set(schools, forKey: "schools")
        }
    }

    // MARK: - NSKeyedUnarchiverDelegate

    func unarchiver(_ unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String,
                    originalClasses classNames: [String]) -> AnyClass? {
        return School.self
    }
}

private let initialSchools = [
    School(name: "Ginta Latina", classes: [
        Class(name: "11B", teacher: "Zuza Olga", students: [
            Student(name: "Muntean Maxim"),
            Student(name: "Garstea Liudmila"),
            Student(name: "Volontir Vasile"),
            Student(name: "Pistol Calatina"),
            Student(name: "Verdes Felicia"),
            Student(name: "Dumbrovan Elena"),
            Student(name: "Uncu Alexandru"),
            Student(name: "Tomsa Octavian"),
            Student(name: "Lazarev Artur"),
            Student(name: "Avtenii Mihaela"),
            Student(name: "Bet Nina"),
            Student(name: "Boicu Monica"),
            Student(name: "Cazac Alina"),
            Student(name: "Rotari Vitalie"),
            Student(name: "Tulbu Alexandru"),
            Student(name: "Mititelu Nicoleta"),
            Student(name: "Taschevici Renata"),
            Student(name: "Buza Irina"),
            Student(name: "Gustei Adriana"),
            Student(name: "Vdovicenco Olga"),
            Student(name: "Gusciuc Victor"),
            Student(name: "Bassarab Ecaterina"),
            Student(name: "Dragoman Alexandra"),
            Student(name: "Curmei Mariana"),
            Student(name: "Razmarita Adriana")
            ]
        ),
        Class(name: "12A", teacher: "Zahara Tatiana", students: [
            Student(name: "Marian Alexandru"),
            Student(name: "Frunza Maxim"),
            Student(name: "Vetiu Daria"),
            Student(name: "Baician Iulia"),
            Student(name: "Izbiscius Natalia"),
            Student(name: "Rusu Francesca", reports:
                [
                    Report(academicRating: .ok, emotionalRating: .veryBad,
                           comment: "She was a very bad girl this month.", date: Date()),
                    Report(academicRating: .good, emotionalRating: .ok,
                           comment: "She was a bit better this month.", date: Date())
                ]
            ),
            Student(name: "Chintea Robert"),
            Student(name: "Motrencu Artemis"),
            Student(name: "Gaina Natalia"),
            Student(name: "Gordnean Valentina"),
            Student(name: "Cristescu Emilia"),
            Student(name: "Ungureanu Mihai")
            ])
        ]),
    School(name: "Miguel de Cervantes", classes: [])
]
