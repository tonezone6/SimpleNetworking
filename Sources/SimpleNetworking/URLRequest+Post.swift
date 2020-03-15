// SimpleNetworking

import Foundation

extension URLRequest {
    public init<T: Encodable>(url: URL, body: T) {
        self.init(url: url)
        httpMethod = "POST"
        addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpBody = try? JSONEncoder().encode(body)
    }
}
