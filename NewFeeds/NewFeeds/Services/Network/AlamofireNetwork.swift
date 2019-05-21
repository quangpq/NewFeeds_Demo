//
//  AlamofireNetwork.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation
import Alamofire
import Codextended

class AlamofireNetwork: INetwork {
    init() {
        
    }
    
    func getNewFeeds(completion: @escaping (Swift.Result<[NFFeed], Error>) -> Void) {
        let urlString = "https://www.dropbox.com/s/fy6ny7syutxl1yd/newsfeed.json?dl=1"
        Alamofire
            .request(urlString,
                     method: .get,
                     encoding: URLEncoding.default)
            .responseData { response in
                if let data = response.data {
                    do {
                        let feedArray = try data.decoded() as NFFeedArray
                        completion(.success(feedArray.items))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.unknown))
                }
            }
    }
    
    func getDetail(id: String, completion: @escaping (Swift.Result<NFDetail, Error>) -> Void) {
        let urlString = "https://www.dropbox.com/s/v83n38kvsm6qw62/detail.json?dl=1"
        
        Alamofire
            .request(urlString,
                     method: .get,
                     encoding: URLEncoding.default)
            .responseData { response in
                if let data = response.data {
                    do {
                        let detail = try data.decoded() as NFDetail
                        completion(.success(detail))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.unknown))
                }
        }
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case unknown
}
