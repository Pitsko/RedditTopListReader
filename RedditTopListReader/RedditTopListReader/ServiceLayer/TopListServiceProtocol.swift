//
//  TopListServiceProtocol.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

protocol TopListServiceProtocol {
    func fetchTopList(limit: Int, after: String?, completion: @escaping (_ data: [Post]?, _ error: Error?) -> ())
}
