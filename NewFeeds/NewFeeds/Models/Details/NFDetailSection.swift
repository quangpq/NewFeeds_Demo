//
//  NFDetailSection.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import Foundation

struct NFDetailSection: Codable {
    let type: ContentType
    let content: Content
    
    enum CodingKeys: String, CodingKey {
        case type = "section_type"
        case content
    }
}

extension NFDetailSection {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawType = try values.decode(Int.self, forKey: .type)
        if let validType = ContentType(rawValue: rawType) {
            type = validType
        } else {
            type = .text
        }
        
        switch type {
        case .text:
            let rawContent = try values.decode(NFDetailSection.TextContent.self, forKey: .content)
            content = .text(rawContent)
        case .image:
            let rawContent = try values.decode(NFDetailSection.ImageContent.self, forKey: .content)
            content = .image(rawContent)
        case .video:
            let rawContent = try values.decode(NFDetailSection.VideoContent.self, forKey: .content)
            content = .video(rawContent)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        
        switch content {
        case .text(let text):
            try container.encode(text, forKey: .content)
        case .image(let image):
            try container.encode(image, forKey: .content)
        case .video(let video):
            try container.encode(video, forKey: .content)
        }
    }
}

extension NFDetailSection {
    enum ContentType: Int, Codable {
        case text = 1
        case video = 2
        case image = 3
    }
    
    enum Content {
        case text(TextContent)
        case image(ImageContent)
        case video(VideoContent)
    }
    
    struct VideoContent: Codable {
        let href: String
        let caption: String
        let duration: Int
        let preview: NFImageItem
        
        enum CodingKeys: String, CodingKey {
            case href
            case caption
            case duration
            case preview = "preview_image"
        }
    }
    
    struct TextContent: Codable {
        let text: String?
    }
    
    struct ImageContent: Codable {
        let href: String
        let caption: String
        let color: String
        let width: Int
        let height: Int
        
        enum CodingKeys: String, CodingKey {
            case href
            case caption
            case color = "main_color"
            case width = "original_width"
            case height = "original_height"
        }
    }
}
