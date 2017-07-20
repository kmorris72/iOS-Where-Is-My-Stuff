//
//  Model.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 6/23/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Model {
    private static var userManager = UserManager.getInstance()
    private static var itemManager = ItemManager.getInstance()
    private static let instance = Model()
    
    private static let databaseRef = Database.database().reference()
    
    static func getInstance() -> Model {
        return instance
    }
    
    func setUp() {
        Model.userManager.setUp()
        Model.itemManager.setUp()
    }
    
    func addUser(firstName: String?, lastName: String?, email: String?, username: String?, password1: String?, password2: String?, isAdmin: Bool) -> Int {
        return Model.userManager.addUser(firstName: firstName, lastName: lastName, email: email, username: username, password1: password1, password2: password2, isAdmin: isAdmin)
    }
    
    func loginUser(usernameEmail: String?, password: String?) -> Int {
        return Model.userManager.loginUser(usernameEmail: usernameEmail, password: password)
    }
    
//    func searchItem(itemName: String?, pickerType: String?) -> Int {
////        return Model.itemManager.searchItem(username)
//    }
    
    func getName() -> String {
        return Model.userManager.getName()
    }
    
    func getCurrentUser() -> User {
        return Model.userManager.getCurrentUser()
    }
    
    func getItemTypes() -> Array<ItemType> {
        return ItemType.values
    }
    
    func addLostItem(name: String, typePosition: Int, description: String, user: User) {
        Model.itemManager.addLostItem(name: name, typePosition: typePosition, description: description, user: user)
    }
    

    func addFoundItem(name: String, type: Int, description: String, user: User) {
        //Where does the user field come in??
        return Model.itemManager.addFoundItem(name: name, typePosition: type, description: description, user: user)
    }
    
    func getLostItems() -> Array<Item> {
        return Model.itemManager.getLostItems()
    }
    
    func getFoundItems() -> Array<Item> {
        return Model.itemManager.getFoundItems()
    }
    
    func searchFound(foundItem: Bool, name: String) -> Bool {
        return Model.itemManager.searchFound(foundItem: foundItem, name: name)
    }
    
    func searchResult(foundItem: Bool, name: String) -> String {
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
        
        func getUsername() -> String {
            return _username
        }
        
        func checkPassword(password: String) -> Bool {
            return password == _password
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
        case technological = "TECHNOLOGICAL"
        case furniture = "FURNITURE"
        case recreational = "RECREATIONAL"
        case personal = "PERSONAL"
        case pet = "PET"
        case other = "OTHER"
        
        static let values = [technological, furniture, recreational, personal, pet, other]
    }
    
}
