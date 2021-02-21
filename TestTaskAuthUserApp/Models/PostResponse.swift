

import Foundation

struct PostResponse: Codable {
    let success: String
    let response: Token?
}

struct Token: Codable {
    let token: String
}
