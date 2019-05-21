//
//  NFDetail.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

struct NFDetail: Codable {
    let id: String
    let title: String
    let description: String
    let dateString: String
    let originURL: String
    let publisher: NFPublisher?
    let sections: [NFDetailSection]?

    enum CodingKeys: String, CodingKey {
        case id = "document_id"
        case title
        case description
        case dateString = "published_date"
        case originURL = "origin_url"
        case publisher
        case sections
    }
}

