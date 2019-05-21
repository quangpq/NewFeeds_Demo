//
//  DetailTextTableCell.swift
//  NewFeeds
//
//  Created by Quang Phan on 21/05/2019.
//  Copyright © 2019 Quang Phan. All rights reserved.
//

import UIKit

class DetailTextTableCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textView.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setData(_ data: NFDetailSection.TextContent) {
        textView.text = data.text
    }
    
}
