// SimpleNetworking

import Foundation

extension URLRequest {
    public init<A: Encodable>(url: URL, body: A) {
        self.init(url: url)
        httpMethod = "POST"
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpBody = try? JSONEncoder().encode(body)
    }
}
