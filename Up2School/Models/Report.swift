//
//  Report.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

class Report: NSObject, NSCoding {
    let academicRating: Rating
    let emotionalRating: Rating
    let comment: String
    let date: Date

    init(academicRating: Rating, emotionalRating: Rating, comment: String, date: Date) {
        self.academicRating = academicRating
        self.emotionalRating = emotionalRating
        self.comment = comment
        self.date = date
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        guard let academicRating = Rating(rawValue: aDecoder.decodeInteger(forKey: "academicRating")),
            let emotionalRating = Rating(rawValue: aDecoder.decodeInteger(forKey: "emotionalRating")),
            let comment = aDecoder.decodeObject(forKey: "comment") as? String,
            let date = aDecoder.decodeObject(forKey: "date") as? Date else {
                return nil
        }
        self.academicRating = academicRating
        self.emotionalRating = emotionalRating
        self.comment = comment
        self.date = date
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(academicRating.rawValue, forKey: "academicRating")
        aCoder.encode(emotionalRating.rawValue, forKey: "emotionalRating")
        aCoder.encode(comment, forKey: "comment")
        aCoder.encode(date, forKey: "date")
    }
}

enum Rating: Int {
    case veryBad = 1, bad, ok, good, veryGood
}
