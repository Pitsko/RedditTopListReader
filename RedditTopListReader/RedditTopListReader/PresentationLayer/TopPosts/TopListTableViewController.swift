//
//  ViewController.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import UIKit

class TopListTableViewController: UITableViewController {

    private struct Constants {
        static let footerSize: CGFloat = 60.0
        static let portionSize: Int = 20
    }

    private var topListService: TopListServiceProtocol {
        return ServiceLocator.getService()
    }

    private var footerloadingIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    
    private enum LoadingStatus {
        case inProgress
        case idle
        case noMoreData
    }
    
    private var loadingState: LoadingStatus = .idle {
        didSet {
            if loadingState == .inProgress {
                tableView.tableFooterView = footerloadingIndicatorView
            } else {
                tableView.tableFooterView = nil
            }
        }
    }
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TopListTableViewCell", bundle: nil), forCellReuseIdentifier: TopListTableViewCell.rIdentifier)
        fetchMorePostsIfNeeded(0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopListTableViewCell.rIdentifier) as! TopListTableViewCell
        cell.configure(post: posts[indexPath.row], thumbnailTapped: { (post) in
            let images = post.preview?.images
            if let images = images, images.count > 0 {
                let imageSourceURL = images[0].source.url
                UIApplication.shared.open(imageSourceURL, options: [:], completionHandler: nil)
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        fetchMorePostsIfNeeded(indexPath.row)
    }
    
    func fetchMorePostsIfNeeded(_ currentIndex: Int) {
        if currentIndex >= posts.count - 1 && loadingState == .idle {
            loadingState = .inProgress
            let after = posts.last?.name
            topListService.fetchTopList(limit: Constants.portionSize, after: after) { [weak self](data, error) in
                guard let strongSelf = self else {
                    return
                }
                
                guard let data = data, error == nil else {
                    strongSelf.showLoadingError()
                    return
                }
                
                if data.count > 0 {
                    strongSelf.posts.append(contentsOf: data)
                    strongSelf.loadingState = .idle
                } else {
                    strongSelf.loadingState = .noMoreData
                }
            }
        }
    }
    
    private func showLoadingError() {
        let alert = UIAlertController(title: "Error", message: "Error during data loading", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}

