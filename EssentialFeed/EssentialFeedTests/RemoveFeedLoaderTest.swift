//
//  RemoveFeedLoaderTest.swift
//  EssentialFeedTests
//
//  Created by Costa on 10/22/23.
//

import XCTest
import EssentialFeed


final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_noRequestUpponCreation() {
        let (client, _) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromUrl() {
        let url = URL(string: "https://www.a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requestDataFromUrlTwice() {
        let url = URL(string: "https://www.a-given-url.com")!
        let (client, sut) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_requestCompletesWithConnectivityError() {
        //Arrange
        let (client, sut) = makeSUT()
        let clientError = NSError(domain: "test", code: -1)
        
        //Act
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load() { capturedErrors.append($0) }
        client.complete(with: clientError)
        
        //Assert
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    func test_load_requestCompletesWithInvalidDataError() {
        let (client, sut) = makeSUT()
        let samples = [199,201,400,500]
        
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteFeedLoader.Error]()
            sut.load() { capturedErrors.append($0) }
            client.complete(withStatusCode: code, for: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
        }        
    }
    
    // MARK: - helpers
    
    private func makeSUT(url: URL = URL(string: "https://www.a-url.com")!) -> (client: HTTPClientSpy, sut: RemoteFeedLoader) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (client, sut)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HttpClientResult) -> Void)]()
        
        var requestedURLs: [URL] {
            messages.map { $0.url }
        }

        func get(from url: URL, with completion: @escaping (HttpClientResult) -> Void) {
            messages.append((url,completion))
        }
        
        func complete(with error: Error, for index: Int = 0){
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode statusCode: Int, for index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                                  statusCode: statusCode,
                                                  httpVersion: nil,
                                                  headerFields: nil)!
            
            messages[index].completion(.success(response))
        }
    }
}
