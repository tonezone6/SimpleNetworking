// SimpleNetworking

import Foundation

public extension URLSession {
    struct Server {
        let scheme: String
        let host: String
    }

    struct Endpoint {
        let server: Server
        let path: String
        let queryItems: [URLQueryItem]?
        
        init(server: Server, path: String, queryItems: [URLQueryItem]? = nil) {
            self.server = server
            self.path = path
            self.queryItems = queryItems
        }
        
        var url: URL? {
            var components = URLComponents()
            components.scheme = server.scheme
            components.host = server.host
            components.path = path
            components.queryItems = queryItems
            
            return components.url
        }
    }
}

