

import Foundation

struct User: Codable {
    let login: String
    let password: String
    
    static func getUserData() -> User {
        User(login: "demo", password: "12345")
    }
}
