//
//  TopListService.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import Foundation

class TopListService: TopListServiceProtocol {
    
    private struct Constants {
        static let baseURL = "https://www.reddit.com/"
    }
    
    func fetchTopList(limit: Int, after: String? = nil, completion: @escaping (_ data: [Post]?, _ error: Error?) -> () ) {
        
        var urlStirng = "\(Constants.baseURL)top.json?limit=\(limit)&t=day"
        if let after = after  {
            urlStirng = urlStirng + "&after=\(after)"
        }
        
        guard let url = URL(string: urlStirng) else {
            assertionFailure("issue with creating url, \(urlStirng)")
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            let decoder = JSONDecoder()
            
            let response = try! decoder.decode(TopListServiceResponse.self, from: data!)
            
            let posts = response.data.children.map{$0.data}
            
            DispatchQueue.main.async {
                completion(posts, error)
            }
        }.resume()
        
    }
}
