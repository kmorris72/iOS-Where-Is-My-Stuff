//
//  Model.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/23/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit

class Model {
    
    private static var userManager = UserManager.getInstance()
    private static var itemManager = ItemManager.getInstance()
    private static let instance = Model()
    
    public static func getInstance() -> Model {
        return instance
    }
    
    public func addUser(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?, isAdmin: Bool) -> Int {
        return Model.userManager.addUser(firstName: firstName, lastName: lastName, email: email, username: username, password1: password1, password2: password2, isAdmin: isAdmin)
    }
    
    public func loginUser(usernameEmail: String, password: String) -> Int {
        return Model.userManager.loginUser(usernameEmail: usernameEmail, password: password)
    }
    
    public func getName() -> String {
        return Model.userManager.getName()
    }
    
    public func getCurrentUser() -> User {
        return Model.userManager.getCurrentUser()
    }
    
    public func getItemTypes() -> Array<ItemType> {
        return ItemType.values
    }
    
    public func addLostItem(name: String, type: Int, description: String, user: User) {
        Model.itemManager.addLostItem(name: name, typePosition: type, description: description, user: user)
    }
    
    public func addFoundItem(name: String, type: Int, description: String, user: User) {
        Model.itemManager.addFoundItem(name: name, typePosition: type, description: description, user: user)
    }
    
    public func getLostItems() -> Array<Item> {
        return Model.itemManager.getLostItems()
    }
    
    public func getFoundItems() -> Array<Item> {
        return Model.itemManager.getFoundItems()
    }
    
    public func searchFound(foundItem: Bool, name: String) -> Bool {
        return Model.itemManager.searchFound(foundItem: foundItem, name: name)
    }
    
    public func searchResult(foundItem: Bool, name: String) -> String {
        return Model.itemManager.searchResult(foundItem: foundItem, name: name)
    }
    
    struct User {
        private var _firstName: String!
        private var _lastName: String!
        private var _email: String!
        private var _username: String!
        private var _password: String!
        private var _isAdmin: Bool
        
        init(firstName: String, lastName: String, email: String, username: String, password: String, isAdmin: Bool) {
            _firstName = firstName
            _lastName = lastName
            _email = email
            _username = username
            _password = password
            _isAdmin = isAdmin
        }
        
        func getName() -> String {
            return (_lastName.characters.count == 0) ? _firstName : _firstName + " " + _lastName
        }
        
        func checkPassword(password: String) -> Bool {
            return password == _password
        }
    }
    
    struct UserManager {
        private var _currentUser: User!
        private var _users: Dictionary<String, User>
        private var _emailUser: Dictionary<String, String>
        private static let instance = UserManager()
        
        private init() {
            _users = Dictionary<String, User>()
            _emailUser = Dictionary<String, String>()
            setUp()
        }
        
        static func getInstance() -> UserManager {
            return instance
        }
        
        private mutating func setUp() {
            addUser(firstName: "admin", lastName: "one", email: "admin@gatech.edu", username: "user", password1: "pass", password2: "pass", isAdmin: true)
        }
        
        private func validateInput(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?) -> Int {
            if let firstName = firstName, let lastName = lastName {
                if (firstName.characters.count == 0 || lastName.characters.count == 0) {
                    return 1
                }
            } else {
                return 1
            }
            if let email = email {
                if (email.characters.count == 4 || email.range(of: "@") == nil) {
                    return 2
                } else if (_emailUser[email] != nil) {
                    return 8
                }
            } else {
                return 2
            }
            if let username = username {
                if (username.characters.count == 0) {
                    return 3
                } else if (username.range(of: " ") != nil) {
                    return 4
                } else if (username.range(of: "@") != nil) {
                    return 5
                } else if (_users[username] != nil) {
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
            return 0
        }
        
        mutating func addUser(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?, isAdmin: Bool) -> Int {
            let code = validateInput(firstName: firstName, lastName: lastName, email: email, username: username, password1: password1, password2: password2)
            if (code == 0) {
                let firstName = firstName!.trimmingCharacters(in: .whitespacesAndNewlines)
                let lastName = lastName!.trimmingCharacters(in: .whitespacesAndNewlines)
                let email = email!.trimmingCharacters(in: .whitespacesAndNewlines)
                let username = username!.trimmingCharacters(in: .whitespacesAndNewlines)
                let newUser = User(firstName: firstName, lastName: lastName, email: email, username: username, password: password1!, isAdmin: isAdmin)
                _users.updateValue(newUser, forKey: username)
                _emailUser.updateValue(username, forKey: email)
                _currentUser = newUser
            }
            return code
        }
        
        mutating func loginUser(usernameEmail: String, password: String) -> Int {
            let usernameEmail = usernameEmail.trimmingCharacters(in: .whitespacesAndNewlines)
            let user: User!
            let username: Bool
            if (usernameEmail.range(of: "@") != nil) {
                user = _users[usernameEmail]
                username = true
            } else {
                user = _users[_emailUser[usernameEmail]!]
                username = false
            }
            if (usernameEmail.characters.count == 0 || password.characters.count == 0) {
                return 1
            } else if (user == nil && username) {
                return 2
            } else if (user == nil) {
                return 3
            } else if (!user.checkPassword(password: password)) {
                return 4
            } else {
                if (username) {
                    _currentUser = _users[usernameEmail]!
                } else {
                    _currentUser = _users[_emailUser[usernameEmail]!]
                }
                return 0
            }
        }
        
        func getName() -> String {
            if (_currentUser != nil) {
                return _currentUser.getName()
            }
            return "Anonymous"
        }
        
        func getCurrentUser() -> User {
            return _currentUser
        }
    }
    
    struct Item: CustomStringConvertible {
        private var _name: String
        private var _type: ItemType
        private var _description: String
        private var _user: User
        
        var description: String {
            get {
                return _type.rawValue + ": " + _name
            }
        }
        
        init(name: String, type: ItemType, description: String, user: User) {
            _name = name
            _type = type
            _description = description
            _user = user
        }
        
        func getName() -> String {
            return _name
        }
        
        func getDescription() -> String {
            return "Name: " + _name + "/nType: "
        }
    }
    
    enum ItemType: String {
        case technological = "Technological"
        case furniture = "Furniture"
        case recreational = "Recreational"
        case personal = "Personal"
        case pet = "Pet"
        case other = "Other"
        
        static let values = [technological, furniture, recreational, personal, pet, other]
    }
    
    struct ItemManager {
        private var _lostItems: Dictionary<String, Item>
        private var _foundItems: Dictionary<String, Item>
        private static let instance = ItemManager()
        
        private init() {
            _lostItems = Dictionary<String, Item>()
            _foundItems = Dictionary<String, Item>()
        }
        
        static func getInstance() -> ItemManager {
            return instance
        }
        
        mutating func addLostItem(name: String, typePosition: Int, description: String, user: User) {
            let type = ItemType.values[typePosition]
            _lostItems.updateValue(Item(name: name, type: type, description: description, user: user), forKey: name)
        }
        
        mutating func addFoundItem(name: String, typePosition: Int, description: String, user: User) {
            let type = ItemType.values[typePosition]
            _foundItems.updateValue(Item(name: name, type: type, description: description, user: user), forKey: name)
        }
        
        func getLostItems() -> Array<Item> {
            return Array(_lostItems.values)
        }
        
        func getFoundItems() -> Array<Item> {
            return Array(_foundItems.values)
        }
        
        func searchFound(foundItem: Bool, name: String) -> Bool {
            if (foundItem) {
                return _foundItems[name] != nil
            } else {
                return _lostItems[name] != nil
            }
        }
        
        func searchResult(foundItem: Bool, name: String) -> String {
            if (foundItem) {
                return _foundItems[name]!.getDescription()
            } else {
                return _lostItems[name]!.getDescription()
            }
        }
    }
    
}
