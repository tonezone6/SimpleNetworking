// SimpleNetworking

import Foundation

public protocol URLSessionProtocol {
    func load<T: Decodable>(_ type: T.Type, with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
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
    public func load<T: Decodable>(_ type: T.Type, with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        data(with: request) { loadingResult in
            switch loadingResult {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let result = Result { try JSONDecoder().decode(T.self, from: data) }
                completion(result)
            }
        }
    }
}
