//
//  UserManager.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 7/17/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserManager {
    private var _currentUser: Model.User!
    private var _users: Dictionary<String, Model.User>
    private var _emailUser: Dictionary<String, String>
    private static let instance = UserManager()

    private let databaseRef = Database.database().reference()
    private let auth = Auth.auth()
    
    private let _usersDatabase: DatabaseReference
    
    private init() {
        _users = Dictionary<String, Model.User>()
        _emailUser = Dictionary<String, String>()
        _usersDatabase = databaseRef.child("users")
    }
    
    static func getInstance() -> UserManager {
        return instance
    }
    
    private func setUpAddUser(user: Model.User) {
        _users[user.getUsername()] = user
    }
    
    func setUp() {
        _usersDatabase.observe(DataEventType.value, with: { (snapshot) in
            for userSnap in snapshot.children.allObjects as! [DataSnapshot] {
                let user = DatabaseHelper.parseUser(userSnap: userSnap)
                self.setUpAddUser(user: user)
            }
        })
        let admin = Model.User(firstName: "admin", lastName: "one", email: "admin@gatech.edu", username: "user", password: "pass", isAdmin: true)
        self.setUpAddUser(user: admin)
    }
    
    private func validateInput(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?) -> Int {
        if let firstName = firstName, let lastName = lastName {
            if (firstName.characters.count == 0 || lastName.characters.count == 0) {
                return 1
            }
            if let email = email {
                if (email.characters.count == 0 || email.range(of: "@") == nil) {
                    return 2
                } else if let emailUser = _emailUser[email] {
                    return 8
                }
                if let username = username {
                    if (username.characters.count == 0) {
                        return 3
                    } else if (username.range(of: " ") != nil) {
                        return 4
                    } else if (username.range(of: "@") != nil) {
                        return 5
                    } else if let user = _users[username] {
                        return 9
                    }
                } else {
                    return 3
                }
                if let password1 = password1, let password2 = password2 {
                    if (password1.characters.count == 0 || password2.characters.count == 0) {
                        return 6
                    } else if (!(password1 == password2)) {
                        return 7
                    }
                } else {
                    return 6
                }
            } else {
                return 2
            }
        } else {
            return 1
        }
        return 0
    }
    
    func addUser(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?, isAdmin: Bool) -> Int {
        let code = validateInput(firstName: firstName, lastName: lastName, email: email, username: username, password1: password1, password2: password2)
        if (code == 0) {
            let firstName = firstName!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastName!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = email!.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = username!.trimmingCharacters(in: .whitespacesAndNewlines)
            let newUser = Model.User(firstName: firstName, lastName: lastName, email: email, username: username, password: password1!, isAdmin: isAdmin)
            _users.updateValue(newUser, forKey: username)
            _emailUser.updateValue(username, forKey: email)
            _currentUser = newUser
            
            // may still need to add name field to database (firstname and lastName separated by a space) bc they have it in theirs
            let userRef = self._usersDatabase.child(username)
            let userMirror = Mirror(reflecting: _currentUser as Model.User)
            var userInfo: [String : Any] = [:]
            for (label, value) in userMirror.children {
                userInfo[label!.replacingOccurrences(of: "_", with: "")] = value
            }
            userInfo["name"] = (userInfo["firstName"] as! String) + " " + (userInfo["lastName"] as! String)
            userRef.setValue(userInfo)
        }
        return code
    }
    
    func loginUser(usernameEmail: String?, password: String?) -> Int {
        if let _usernameEmail = usernameEmail, let _password = password {
            if (_usernameEmail.characters.count == 0 || _password.characters.count == 0) {
                return 1
            }
            let user: Model.User?
            let username: Bool
            if (_usernameEmail.range(of: "@") == nil) {
                user = _users[_usernameEmail]
                username = true
            } else {
                user = _users[_emailUser[_usernameEmail]!]
                username = false
            }
            if (_usernameEmail.characters.count == 0 || password?.characters.count == 0) {
                return 1
            }
            else if let user = user {
                if (!user.checkPassword(password: _password)) {
                    return 4
                } else {
                    auth.createUser(withEmail: _currentUser.getEmail(), password: _currentUser.getPassword(), completion: nil)
                    _currentUser = user
                    return 0
                }
            } else if username {
                return 2
            } else {
                return 3
            }
        } else {
            return 1
        }
    }
    
    func getName() -> String {
        if let _currentUser = _currentUser {
            return _currentUser.getName()
        } else {
            return "Anonymous"
        }
    }
    
    func getCurrentUser() -> Model.User {
        return _currentUser
    }
    
    //        mutating func addLostItem(name: String?, typePosition: String?, description: String?) -> Int {
    //            //Can the Spinner be a string?
    //            let _name: String?
    //            let _typePosition: String?
    //            let _description: String?
    //
    //            if (name == nil || typePosition == nil || description == nil) {
    //
    //                return 1
    //            } else {
    //                _name = name
    //                _typePosition = typePosition
    //                _description = description
    //            }
    //
    //            if (_name!.characters.count == 0 ||  _typePosition!.characters.count == 0 || _description!.characters.count == 0) {
    //
    //                return 1
    //            }
    //
    //            return 0;
    //        }
}
