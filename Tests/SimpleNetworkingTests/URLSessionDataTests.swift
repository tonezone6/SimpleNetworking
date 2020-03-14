import XCTest
@testable import SimpleNetworking

final class URLSessionDataTests: XCTestCase {
    var data: Data? {
        """
        [
            { "foo": "bar1" },
            { "foo": "bar2" },
            { "foo": "bar3" }
        ]
        """.data(using: .utf8)
    }
 
    struct FooBar: Decodable {
        let foo: String
    }

    func testLoadingItems() throws {
        // given
        let session = URLSession.mock
        let request = URLRequest.mock
        session.data = data
        
        // when
        var result: Result<[FooBar], Error>?
        session.load([FooBar].self, with: request) { result = $0 }
        let items = try result?.get()
    
        // then
        XCTAssertEqual(items?.count, 3)
    }
    
    func testLoadingItemsSuccessDecoding() throws {
        // given
        let session = URLSession.mock
        let request = URLRequest.mock
        session.data = data
        
        // when
        var result: Result<[FooBar], Error>?
        session.load([FooBar].self, with: request) { result = $0 }
        let item = try result?.get().first
    
        // then
        XCTAssertEqual(item?.foo, "bar1")
    }
    
    func testLoadingItemsReceivingError() {
        // given
        let session = URLSession.mock
        let request = URLRequest.mock
        session.error = TestError.mock

        // when
        session.load([FooBar].self, with: request) { result in
            switch result {
            case .success:
                XCTFail("no result error!")
            case .failure(let error):
                // then
                XCTAssertEqual(error.localizedDescription, "mock error")
            }
        }
    }
}
