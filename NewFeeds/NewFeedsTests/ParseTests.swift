//
//  ParseTests.swift
//  NewFeedsTests
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import XCTest
@testable import NewFeeds

class ParseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsePusblisher() {
        let string = """
        {
        \"id\": \"ahf_24h\",
        \"name\": \"24h\",
        \"icon\": \"http://cdn.marketplaceimages.windowsphone.com/v8/images/43a06676-4ee2-4875-afb5-03c3d9128679?imageType=ws_icon_medium\"
        }
        """
        
        let decoder = JSONDecoder()
        guard let data = string.data(using: .utf8) else {
            fatalError()
        }
        
        do {
            let publisher = try decoder.decode(NFPublisher.self, from: data)
            assert(publisher.id == "ahf_24h")
            assert(publisher.name == "24h")
            assert(publisher.icon == "http://cdn.marketplaceimages.windowsphone.com/v8/images/43a06676-4ee2-4875-afb5-03c3d9128679?imageType=ws_icon_medium")
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }
    
    func testParseSections() {
        let decoder = JSONDecoder()

        let stringImage = """
        {
          \"section_type\": 3,
          \"content\": {
            \"href\": \"https://cdn.24h.com.vn/upload/1-2019/images/2019-03-06/Real-thua-tham-Cup-C1-Hoc-MU---Solskjaer-ong-trum-Perez-chot-huyen-thoai-1550097027_411801_1550097094_noticia_normal-1551836702-759-width660height371.jpg\",
            \"caption\": \"HLV Solari sắp sửa bị sa thải\",
            \"main_color\": \"#ffffff\",
            \"original_width\": 6699,
            \"original_height\": 4471
          }
        }
        """
        
        guard let dataImage = stringImage.data(using: .utf8) else {
            fatalError()
        }
        
        do {
            let image = try decoder.decode(NFDetailSection.self, from: dataImage)
            assert(image.type == .image)
            switch image.content {
            case .image(let i):
                assert(i.href == "https://cdn.24h.com.vn/upload/1-2019/images/2019-03-06/Real-thua-tham-Cup-C1-Hoc-MU---Solskjaer-ong-trum-Perez-chot-huyen-thoai-1550097027_411801_1550097094_noticia_normal-1551836702-759-width660height371.jpg")
                assert(i.caption == "HLV Solari sắp sửa bị sa thải")
                assert(i.color == "#ffffff")
                assert(i.width == 6699)
                assert(i.height == 4471)
            default:
                fatalError()
            }
        } catch let err {
            fatalError(err.localizedDescription)
        }
        
        let stringText = """
        {
          \"section_type\": 1,
          \"content\": {
            \"text\": \"test data\",
            \"markups\": []
          }
        }
        """
        
        guard let dataText = stringText.data(using: .utf8) else {
            fatalError()
        }
        
        do {
            let text = try decoder.decode(NFDetailSection.self, from: dataText)
            assert(text.type == .text)
            switch text.content {
            case .text(let t):
                assert(t.text == "test data")
            default:
                fatalError()
            }
        } catch let err {
            fatalError(err.localizedDescription)
        }
        
        let stringVideo = """
        {
          \"section_type\": 2,
          \"content\": {
            \"href\": \"https://cdn.24h.com.vn/upload/1-2019/videoclip/2019-03-06/1551830356-real_ajax.mp4\",
            \"caption\": \"Np Juđấu được coi là chung kết sớm tại Serie A năm nay\",
            \"duration\": 120,
            \"preview_image\": {
              \"href\": \"https://cdn.24h.com.vn/upload/1-2019/images/2019-03-06/1551830356-real_ajax.jpg\",
              \"main_color\": \"#563a3a\",
              \"width\": 480,
              \"height\": 640
            }
          }
        }
        """
        
        guard let dataVideo = stringVideo.data(using: .utf8) else {
            fatalError()
        }
        
        do {
            let video = try decoder.decode(NFDetailSection.self, from: dataVideo)
            assert(video.type == .video)
            switch video.content {
            case .video(let v):
                assert(v.href == "https://cdn.24h.com.vn/upload/1-2019/videoclip/2019-03-06/1551830356-real_ajax.mp4")
                assert(v.caption == "Np Juđấu được coi là chung kết sớm tại Serie A năm nay")
                assert(v.duration == 120)
            default:
                fatalError()
            }
        } catch let err {
            fatalError(err.localizedDescription)
        }
    }

}
