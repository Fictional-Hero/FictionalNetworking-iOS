// Consumer should be able to pass in the response type, or array types.
// Try to cast to the first type. if it fails move to the next.
// Improve performance by counting the times a specific type is used, and sorting by most frequent.
// Consumer passes in the URL (String or URL?)
// All protocols should move to a Core Module.
// This module will only have the concrets.

public protocol FictionalNetworking {
    func fetch(requestURL: String) async throws -> Data
//    func fetch<T>(requestURL: String) -> T
}

import Foundation

class ConcreteFictionalNetworking: FictionalNetworking {
    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    func fetch(requestURL: String) async throws -> Data {
        do {
            let response = try await downloader.httpData(from: URL(fileURLWithPath: requestURL))
            return response
        } catch {
            throw ErrorNetwork()
        }
    }
}



// Do we need a token client?

public protocol FictionalNetworkToken {
    func genToken() -> String
}






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
