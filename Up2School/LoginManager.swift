//
//  LoginManager.swift
//  Up2School
//
//  Created by Alexandru Culeva on 4/16/17.
//  Copyright © 2017 Up2School. All rights reserved.
//

import Foundation

final class LoginManager: NSObject, NSKeyedUnarchiverDelegate {

    private static let defaults = UserDefaults.standard
    static let instance = LoginManager()

    var currentUser: User?

    private static var users: [User] {
        get {
            let datas = defaults.array(forKey: "users") as? [Data] ?? []
            return datas.flatMap { data in
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                unarchiver.delegate = instance
                return unarchiver.decodeObject(forKey: "root") as? User
            }
        } set {
            let users = newValue.map { NSKeyedArchiver.archivedData(withRootObject: $0) }
            defaults.set(users, forKey: "users")
        }
    }

    static func login(email: String, password: String) -> Bool {
        guard let user = users.lazy.filter({ $0.email == email }).first else {
            return false
        }
        instance.currentUser = user
        return true
    }
    static func signUp(_ user: User) {
        users += [user]
    }

    // MARK: - NSKeyedUnarchiverDelegate

    func unarchiver(_ unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String,
                    originalClasses classNames: [String]) -> AnyClass? {
        return User.self
    }
}

class User: NSObject, NSCoding {
    let email: String
    let firstName: String
    let lastName: String
    let password: String
    let phoneNumber: String

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
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
    }
}
