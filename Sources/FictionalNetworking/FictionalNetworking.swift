// Consumer should be able to pass in the response type, or array types.
// Try to cast to the first type. if it fails move to the next.
// Improve performance by counting the times a specific type is used, and sorting by most frequent.
// Consumer passes in the URL (String or URL?)
// All protocols should move to a Core Module.
// This module will only have the concrets.

import Foundation

public class ConcreteFictionalNetworking {
    
    public init() {
        usingURLSession()
    }
    
    func usingURLSession() {
        let session = URLSession(configuration: .ephemeral)
        let url = URL(string: "https://www.google.com")!
        let urlResuest = URLRequest(url: url)
        let sessionReq = session.dataTask(with: urlResuest) { data,response,error  in
            print(response)
        }
        sessionReq.resume()
    }
}



// Do we need a token client?

public protocol FictionalNetworkToken {
    func genToken() -> String
}

//class URLSessionConfig: URLSessionConfiguration




let validStatus = 200...299


protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}


extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw ErrorNetwork()
        }
        return data
    }
}

class ErrorNetwork: Error {}
