//
//  User.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/17/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let phoneNumber: String
    var type = userType

    init(email: String, firstName: String, lastName: String,
         password: String, phoneNumber: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.phoneNumber = phoneNumber
    }

    // MARK: - NSCoding

    required init?(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String ?? ""
        super.init()
        type = UserType(rawValue: aDecoder.decodeInteger(forKey: "userType")) ?? type
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(type.rawValue, forKey: "userType")
    }
}
