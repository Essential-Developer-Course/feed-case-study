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
        let (client, _) = makeSUT(url: url)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_URLRequestedOnLoadCall() {
        let url = URL(string: "https://www.a-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    //MARK - helpers
    
    func makeSUT(url: URL = URL(string: "https://www.a-url.com")!) -> (HTTPClientSpy, RemoteFeedLoader) {
        let client = HTTPClientSpy()
        return (client, RemoteFeedLoader(url: url, client: client))
    }
    
    class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(url: URL) {
            requestedURL = url
        }
    }
    
}
