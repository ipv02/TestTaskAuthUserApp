

import Foundation

struct Payment: Decodable {
    let success: String
    let response: [PaymentData]
}

struct PaymentData: Decodable {
    let desc: String
    let amount: Amount
    let currency: String?
    let created: Double
}

enum Amount: Decodable {
    case double(Double)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                            debugDescription: "Wrong type for Amount"))
    }
}
