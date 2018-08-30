//
//  TopListTableViewCell.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import UIKit

class TopListTableViewCell: UITableViewCell {
    static let rIdentifier = "TopListTableViewCell"
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var commentsCount: UILabel!
    @IBOutlet private weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(post: Post) {
        title.text = post.title
        author.text = post.author
        commentsCount.text = "\(post.num_comments) comms"
        time.text = post.created.timeAgoFormat()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        author.text = ""
        commentsCount.text = ""
        time.text = ""
        thumbnail.image = nil
    }
}
