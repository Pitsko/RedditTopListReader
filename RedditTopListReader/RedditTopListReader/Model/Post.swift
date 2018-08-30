//
//  Post.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import Foundation

// I can simplify model to have all fields in one entity, but I think it this case it is better to follow API model

// Model structure: TopListServiceResponse -> TopListServiceData -> TopListChildren -> Post
struct TopListServiceResponse: Decodable {
    let data: TopListServiceData
}

struct TopListServiceData: Decodable {
    let children: [TopListChildren]
}

struct TopListChildren: Decodable {
    let data: Post
}

struct Post: Decodable {
    
    let name: String
    let author: String
    let title: String
    let created: Date
    
    let num_comments: Int
    let thumbnail: URL?
    
}
