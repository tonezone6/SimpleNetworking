//
//  File.swift
//  
//
//  Created by Alex on 14/03/2020.
//

import Foundation
import SimpleNetworking

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func load<T: Decodable>(_ type: T.Type, with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let value = try decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch(let error) {
                completion(.failure(error))
            }
        }
        if let error = error {
            completion(.failure(error))
        }
    }
}

extension URLSession {
    static var mock: URLSessionMock {
        URLSessionMock()
    }
}
