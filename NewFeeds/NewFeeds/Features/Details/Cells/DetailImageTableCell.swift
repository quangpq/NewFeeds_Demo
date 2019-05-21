//
//  DetailImageTableCell.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit

class DetailImageTableCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
        previewImageView.cancelDownloadTask()
    }

    func setData(_ data: NFDetailSection.ImageContent) {
        captionLabel.text = data.caption
        previewImageView.setWebImage(data.href)
    }
}
