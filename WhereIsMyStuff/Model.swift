public class Model {

    struct User {
        private var _firstName: String
        private var _lastName: String
        private var _email: String
        private var _username: String
        private var _password: String
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
    }
}
