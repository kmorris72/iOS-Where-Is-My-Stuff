public class Model {

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
            _users = Dictionary()
            _emailUser = Dictionary()
            setUp()
        }
        
        static func getInstance() -> UserManager {
            return instance
        }
        
        private mutating func setUp() {
            addUser(firstName: "admin", lastName: "one", email: "admin@gatech.edu", username: "user", password1: "pass", password2: "pass", isAdmin: true)
        }
        
        private func validateInput(firstName: String!, lastName: String!, email: String!, username: String!, password1: String!, password2: String!) -> Int {
            if (firstName == nil || lastName == nil || firstName.characters.count == 0 || lastName.characters.count == 0) {
                return 1
            } else if (email == nil || email.characters.count == 4 || email.range(of: "@") == nil) {
                return 2
            } else if (username == nil || username.characters.count == 0) {
                return 3
            } else if (username.range(of: " ") != nil) {
                return 4
            } else if (username.range(of: "@") != nil) {
                return 5
            } else if (password1 == nil || password2 == nil || password1.characters.count == 0 || password2.characters.count == 0) {
                return 6
            } else if (!(password1 == password2)) {
                return 7
            } else if (_emailUser[email] != nil) {
                return 8
            } else if (_users[username] != nil) {
                return 9
            } else {
                return 0
            }
        }
        
        mutating func addUser(firstName: String, lastName: String, email: String, username: String, password1: String, password2: String, isAdmin: Bool) -> Int {
            let firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
            let code = validateInput(firstName: firstName, lastName: lastName, email: email, username: username, password1: password1, password2: password2)
            if (code == 0) {
                let newUser = User(firstName: firstName, lastName: lastName, email: email, username: username, password: password1, isAdmin: isAdmin)
                _users.updateValue(newUser, forKey: username)
                _emailUser.updateValue(username, forKey: email)
                _currentUser = newUser
            }
            return code
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
