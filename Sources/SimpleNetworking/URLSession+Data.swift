// SimpleNetworking

import Foundation

public protocol URLSessionProtocol {
    func load<A: Codable>(_ type: A.Type, with request: URLRequest, completion: @escaping (Result<A, Error>) -> Void)
}

enum URLSessionError: LocalizedError {
    case unknown
}

extension URLSession {
    public func data(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        dataTask(with: request) { (data, _, error) in
            let result = data.map(Result.success) ?? .failure(error ?? URLSessionError.unknown)
            completion(result)
        }
        .resume()
    }
}

extension URLSession: URLSessionProtocol {
    public func load<A: Codable>(_ type: A.Type, with request: URLRequest, completion: @escaping (Result<A, Error>) -> Void) {
        data(with: request) { loadingResult in
            switch loadingResult {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let result = Result { try JSONDecoder().decode(A.self, from: data) }
                completion(result)
            }
        }
    }
}
