//
//  NewFeedTableCell.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit

class NewFeedTableCell: UITableViewCell {

    @IBOutlet weak var shadowView: QPShadowView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.cancelDownloadTask()
        previewImageView.image = nil
        avatarImageView.cancelDownloadTask()
        avatarImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        shadowView.setShadow(shadowColor: UIColor.darkGray.cgColor, shadowRadius: 5)
        
        previewImageView.clipsToBounds = true
        previewImageView.contentMode = .scaleAspectFill
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
        avatarImageView.layer.masksToBounds = true
    }
    
    func setData(_ item: NFFeed) {
        titleLabel.text = item.title
        contentLabel.text = item.description
        previewImageView.setWebImage(item.getPreviewUrl())
        avatarImageView.setWebImage(item.publisher?.icon, placeholder: UIImage(named: "img_placeholder_user"))
        
        switch item.type {
        case .video:
            typeImageView.image = UIImage(named: "icon_video")
        case .gallery:
            typeImageView.image = UIImage(named: "icon_gallery")
        default:
            typeImageView.image = nil
        }
    }
}
