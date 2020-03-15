// SimpleNetworking

import Foundation

extension URLSession {
    public struct Server {
        let scheme: String
        let host: String
        
        public init(scheme: String, host: String) {
            self.scheme = scheme
            self.host = host
        }
    }

    public struct Endpoint {
        public let server: Server
        public let path: String
        public let queryItems: [URLQueryItem]?
        
        public init(server: Server, path: String, queryItems: [URLQueryItem]? = nil) {
            self.server = server
            self.path = path
            self.queryItems = queryItems
        }
        
        public var url: URL? {
            var components = URLComponents()
            components.scheme = server.scheme
            components.host = server.host
            components.path = path
            components.queryItems = queryItems
            
            return components.url
        }
    }
}

