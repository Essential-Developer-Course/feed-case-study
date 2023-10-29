//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Costa on 10/23/23.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, with completion: @escaping (HttpClientResult) -> Void)
}

public enum HttpClientResult {
    case success(HTTPURLResponse)
    case failure(Error)
}

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(with completion: @escaping (Error) -> Void){
        client.get(from: url) { result in
            switch result {
            case .success(_):
                completion(.invalidData)
            case .failure(_):
                completion(.connectivity)
            }
            
        }
    }
}
