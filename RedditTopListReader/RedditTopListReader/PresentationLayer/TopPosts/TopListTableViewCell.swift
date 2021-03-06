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
    private var post: Post?

    // actually, I dont need to have this action set outside. But I believe controller should responsible for such logic and behavior. Opening of external browser should be not inside cell
    typealias ThumbnailClickClosure = ((_ post: Post) -> ())
    private var thumbnailTapped: ThumbnailClickClosure?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TopListTableViewCell.thumbnailTapped(gesture:)))
        thumbnail.addGestureRecognizer(tapGesture)
    }

    @objc func thumbnailTapped(gesture: UIGestureRecognizer) {
        guard let post = post else {
            return
        }
        thumbnailTapped!(post)
    }

    func configure(post: Post, thumbnailTapped: @escaping ThumbnailClickClosure ) {
        self.post = post
        self.thumbnailTapped = thumbnailTapped
        
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
        post = nil
    }
}
