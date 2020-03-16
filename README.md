# SimpleNetworking

A simple networking solution extending URLSession 

## Usage
Firstly, define your server(s):

```swift
extension URLSession.Server {
    static var development: URLSession.Server {
        URLSession.Server(scheme: "https", host: "www.host-dev.com")
    }
    
    static var release: URLSession.Server {
        URLSession.Server(scheme: "https", host: "www.host.com")
    }
}
```

Then, create the request:

```swift
// GET
var request: URLRequest {
    let queryItems = [
        URLQueryItem(name: "foo1", value: "bar1"),
        URLQueryItem(name: "foo2", value: "bar2")
    ]
    let endpoint = URLSession.Endpoint(
        server: .development, path: "/api/endpoint", queryItems: queryItems)
    return URLRequest(url: endpoint.url!)
}
```

or

```swift
// POST
var request: URLRequest {
    let endpoint = URLSession.Endpoint(server: .development, path: "/api/endpoint")
    let body = FooBar(foo1: "bar1", foo2: "bar2")
    return URLRequest(url: endpoint.url!, body: body)
}
```


And finally, load your resource:

```swift
URLSession.shared.load(FooBar.self, with: request) { result in
    switch result {
    case .failure(let error):
        // handle error...
    case .success(let fooBar):
        // do something... 
    }
}
```
