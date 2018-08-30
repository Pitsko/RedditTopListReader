//
//  ViewController.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import UIKit

class TopListTableViewController: UITableViewController {

    private var topListService: TopListServiceProtocol {
        return ServiceLocator.getService()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topListService.fetchTopList(limit: 10, after: nil) { (posts, error) in
            print(posts)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

