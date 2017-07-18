//
//  ItemManager.swift
//  WhereIsMyStuff
//
//  Created by Kipp Morris on 7/17/17.
//  Copyright © 2017 Fiveloop. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ItemManager {
    private var _lostItems: Dictionary<String, Model.Item>
    private var _foundItems: Dictionary<String, Model.Item>
    private static let instance = ItemManager()
    
    private let databaseRef = Database.database().reference()
    
    private let _lostItemsDatabase: DatabaseReference
    private let _foundItemsDatabase: DatabaseReference
    
    private init() {
        _lostItems = Dictionary<String, Model.Item>()
        _foundItems = Dictionary<String, Model.Item>()
        _lostItemsDatabase = databaseRef.child("lost items")
        _foundItemsDatabase = databaseRef.child("found items")
    }
    
    static func getInstance() -> ItemManager {
        return instance
    }
    
    func setUp() {
        _lostItemsDatabase.observe(DataEventType.value, with: { (snapshot) in
            for itemSnap in snapshot.children.allObjects as! [DataSnapshot] {
                let item = DatabaseHelper.parseItem(itemSnap: itemSnap)
                self._lostItems[item.getName()] = item
            }
        })
        _foundItemsDatabase.observe(DataEventType.value, with: { (snapshot) in
            for itemSnap in snapshot.children.allObjects as! [DataSnapshot] {
                let item = DatabaseHelper.parseItem(itemSnap: itemSnap)
                self._foundItems[item.getName()] = item
            }
        })
    }
    
    func addLostItem(name: String, typePosition: Int, description: String, user: Model.User) {
        let type = Model.ItemType.values[typePosition]
        let item = Model.Item(name: name, type: type, description: description, user: user)
        _lostItems.updateValue(item, forKey: name)
        let itemMirror = Mirror(reflecting: item)
        let itemRef = _lostItemsDatabase.child(name)
        for (label, value) in itemMirror.children {
            switch value {
            case is Model.ItemType:
                itemRef.child(label!.replacingOccurrences(of: "_", with: "")).setValue((value as! Model.ItemType).rawValue)
            case is Model.User:
                let userMirror = Mirror(reflecting: value as! Model.User)
                for (label, value) in userMirror.children {
                    itemRef.child("user").child(label!.replacingOccurrences(of: "_", with: "")).setValue(value)
                }
            default:
                itemRef.child(label!.replacingOccurrences(of: "_", with: "")).setValue(value)
            }
        }
    }
    
    func addFoundItem(name: String, typePosition: Int, description: String, user: Model.User) {
        let type = Model.ItemType.values[typePosition]
        let item = Model.Item(name: name, type: type, description: description, user: user)
        _foundItems.updateValue(item, forKey: name)
        let itemMirror = Mirror(reflecting: item)
        let itemRef = _foundItemsDatabase.child(name)
        for (label, value) in itemMirror.children {
            switch value {
                case is Model.ItemType:
                    itemRef.child(label!.replacingOccurrences(of: "_", with: "")).setValue((value as! Model.ItemType).rawValue)
                case is Model.User:
                    let userMirror = Mirror(reflecting: value as! Model.User)
                    for (label, value) in userMirror.children {
                        itemRef.child("user").child(label!.replacingOccurrences(of: "_", with: "")).setValue(value)
                }
            default:
                itemRef.child(label!.replacingOccurrences(of: "_", with: "")).setValue(value)
            }
        }
    }
    
    func getLostItems() -> Array<Model.Item> {
        return Array(_lostItems.values)
    }
    
    func getFoundItems() -> Array<Model.Item> {
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
