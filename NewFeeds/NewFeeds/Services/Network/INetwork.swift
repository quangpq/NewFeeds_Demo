//
//  INetwork.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

protocol INetwork: class {
    func getNewFeeds(completion: @escaping (Result<[NFFeed], Error>) -> Void)
    func getDetail(id: String, completion: @escaping (Result<NFDetail, Error>) -> Void)
}
