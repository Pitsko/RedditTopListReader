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
    
    private var imageService: ImageServiceProtocol {
        return ServiceLocator.getService()
    }

    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var author: UILabel!
    @IBOutlet private weak var time: UILabel!
    @IBOutlet private weak var commentsCount: UILabel!
    @IBOutlet private weak var thumbnail: UIImageView!
    
    private var imageLoadingTask: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(post: Post) {
        title.text = post.title
        author.text = post.author
        commentsCount.text = "\(post.num_comments) comms"
        time.text = post.created_utc.timeAgoFormat()
        
        if let thumbnailURL = post.thumbnail {
            imageLoadingTask = imageService.loadImage(thumbnailURL) { [weak self](data, error) in
                guard let thumbnail = data, error == nil else {
                    // Ignoring any errors handling here, as it is better dont show image for user than inform about errors in this functionality
                   // assertionFailure("Not possible to load  image, \(String(describing: error))")
                    return
                }
                self?.thumbnail.image = thumbnail
            }
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        author.text = ""
        commentsCount.text = ""
        time.text = ""
        thumbnail.image = nil
        imageLoadingTask?.cancel()
        imageLoadingTask = nil

    }
}
