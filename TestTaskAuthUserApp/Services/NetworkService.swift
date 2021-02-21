

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
   
    //MARK: - POST
    func postRequest(completion: @escaping (PostResponse) -> Void) {
        
        guard let url = URL(string: API.postUrlString) else { return }
        
        let user = User.getUserData()

        guard let userData = try? JSONEncoder().encode(user) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("12345", forHTTPHeaderField: "app-key")
        request.addValue("1", forHTTPHeaderField: "v")
        request.httpBody = userData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let token = try JSONDecoder().decode(PostResponse.self, from: data)
                completion(token)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    //MARK: - GET
    func getRequest(parameters: [String: String], completion: @escaping (Payment) -> Void) {
        
        let parameters = parameters
        let url = self.url(parameters: parameters)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("12345", forHTTPHeaderField: "app-key")
        request.addValue("1", forHTTPHeaderField: "v")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let payment = try JSONDecoder().decode(Payment.self, from: data)
                completion(payment)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func url(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.payments
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
