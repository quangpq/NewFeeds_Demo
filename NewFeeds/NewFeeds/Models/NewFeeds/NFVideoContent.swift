//
//  NFVideoContent.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

struct NFVideoContent: Codable {
    let href: String
    let preview: NFImageItem?
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case href
        case preview = "preview_image"
        case duration
    }
}
