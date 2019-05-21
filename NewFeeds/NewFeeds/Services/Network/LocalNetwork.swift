//
//  LocalNetwork.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation
import Codextended

class LocalNetwork: INetwork {
    
    let feeds: [NFFeed]
    let detail: NFDetail
    
    init() {
        if let feedspath = Bundle.main.path(forResource: "newsfeed", ofType: "json") {
            let url = URL(fileURLWithPath: feedspath)
            
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let feedArray = try data.decoded() as NFFeedArray
                feeds = feedArray.items
            } catch let error {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError()
        }
        
        if let detailpath = Bundle.main.path(forResource: "detail", ofType: "json") {
            let url = URL(fileURLWithPath: detailpath)
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                detail = try data.decoded() as NFDetail
            } catch let error {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError()
        }
    }
    
    func getNewFeeds(completion: @escaping (Result<[NFFeed], Error>) -> Void) {
        completion(.success(feeds))
    }
    
    func getDetail(id: String, completion: @escaping (Result<NFDetail, Error>) -> Void) {
        completion(.success(detail))
    }
}
