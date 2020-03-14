import XCTest
@testable import SimpleNetworking

final class URLRequestPostTests: XCTestCase {
    struct Body: Codable {
        var foo1: String
        var foo2: String
    }
    
    let body = Body(foo1: "bar1", foo2: "bar2")
    let url = URL(string: "https://www.host.com/api/endpoint")!
    
    func testPostRequestUrl() {
        let request = URLRequest(url: url, body: body)
        
        XCTAssertEqual(request.url, URL(string: "https://www.host.com/api/endpoint"))
    }
    
    func testPostRequestBody() {
        let request = URLRequest(url: url, body: body)
        let decoded = try! JSONDecoder().decode(Body.self, from: request.httpBody!)
        
        XCTAssertEqual(decoded.foo1, "bar1")
        XCTAssertEqual(decoded.foo2, "bar2")
    }
    
    func testPostRequestHeaderContentType() {
        let request = URLRequest(url: url, body: body)
        let headers = request.allHTTPHeaderFields
        
        XCTAssertEqual(headers?["Content-Type"], "application/json")
    }
}
