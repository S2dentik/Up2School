//
//  Database.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/15/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

let classesGintaLatina = [
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
]

let schools = [
    School(name: "Ginta Latina", classes: classesGintaLatina),
    School(name: "Miguel de Cervantes", classes: [])
]

struct School {
    let name: String
    let classes: [Class]
}

struct Class {
    let name: String
    let teacher: String
    let students: [Student]
}

struct Student {
    let name: String
    let reports: [Report]
}

extension Student {
    init(name: String) {
        self.init(name: name, reports: [])
    }
}

struct Report {
    let academicRating: Rating
    let emotionalRating: Rating
    let comment: String
    let date: Date
}

enum Rating: Int {
    case veryBad = 1, bad, ok, good, veryGood
}
