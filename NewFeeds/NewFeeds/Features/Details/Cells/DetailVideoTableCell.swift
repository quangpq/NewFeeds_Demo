//
//  DetailVideoTableCell.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit

protocol DetailVideoTableCellDelegate: class {
    func videoCell(didRequestShowVideo cell: DetailVideoTableCell)
}

class DetailVideoTableCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    weak var delegate: DetailVideoTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
        previewImageView.cancelDownloadTask()
        
        delegate = nil
    }
    
    func setData(_ data: NFDetailSection.VideoContent) {
        captionLabel.text = data.caption
        previewImageView.setWebImage(data.preview.href)
    }
    
    @IBAction func didPressedPlayButton(_ sender: UIButton) {
        delegate?.videoCell(didRequestShowVideo: self)
    }
    
}
