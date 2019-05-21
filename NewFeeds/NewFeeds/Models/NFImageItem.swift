//
//  NFImageItem.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

struct NFImageItem: Codable {
    let href: String
    let color: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case href
        case color = "main_color"
        case width
        case height
    }
}
