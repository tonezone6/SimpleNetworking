# SimpleNetworking

A simple networking package using URLSession 

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
var postRequest: URLRequest {
    let endpoint = URLSession.Endpoint(server: .development, path: "/post")
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
