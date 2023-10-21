//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Costa on 10/21/23.
//

import Foundation

enum LoadFeedResult {
    case success(FeedItem)
    case error(Error)
}

protocol FeedLoader {
    func loadfeed(completion: @escaping (LoadFeedResult) -> Void)
}
