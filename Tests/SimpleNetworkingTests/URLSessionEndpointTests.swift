import XCTest
@testable import SimpleNetworking

final class SimpleNetworkingTests: XCTestCase {
    
    func testEndpointUrlFormat() {
        let server = URLSession.Server(scheme: "https", host: "www.host.com")
        let endpoint = URLSession.Endpoint(server: server, path: "/api/endpoint")
        
        XCTAssertEqual(endpoint.url, URL(string: "https://www.host.com/api/endpoint"))
    }
    
    func testEndpointQueryItemsUrlFormat() {
        let qitems = [
            URLQueryItem(name: "foo1", value: "bar1"),
            URLQueryItem(name: "foo2", value: "bar2"),
        ]
        let server = URLSession.Server(scheme: "https", host: "www.host.com")
        let endpoint = URLSession.Endpoint(server: server, path: "/api/endpoint", queryItems: qitems)
        
        XCTAssertEqual(endpoint.url, URL(string: "https://www.host.com/api/endpoint?foo1=bar1&foo2=bar2"))
    }
}
