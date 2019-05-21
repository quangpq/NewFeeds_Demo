//
//  UIImage+KingFisher.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setWebImage(_ urlString: String?, placeholder: UIImage? = nil, completed: ((Bool) -> ())? = nil) {
        
        if let urlStr = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        {
            guard let url = URL(string: urlStr) else {
                completed?(false)
                return
            }
            let processor = DownsamplingImageProcessor(size: self.bounds.size)
//                >> RoundCornerImageProcessor(cornerRadius: 20)
            self.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(_):
                    completed?(true)
                case .failure(let error):
                    completed?(false)
//                    print("Download image failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func cancelDownloadTask() {
        self.kf.cancelDownloadTask()
    }
}
