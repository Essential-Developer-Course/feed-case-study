//
//  RemoveFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Costa on 10/22/23.
//

import XCTest
@testable import EssentialFeed

class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load(){
        client.get(url: url)
    }
}

protocol HTTPClient {
    func get(url: URL)
}

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_noURLRequestedOnInit() {
        let url = URL(string: "https://www.a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_URLRequestedOnLoadCall() {
        let url = URL(string: "https://www.a-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    //MARK - helpers
    
    class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(url: URL) {
            requestedURL = url
        }
    }
    
}
