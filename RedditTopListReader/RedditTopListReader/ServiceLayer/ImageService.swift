//
//  ImageService.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//
import UIKit

class ImageService: ImageServiceProtocol {
    func loadImage(_ url: URL, completion: @escaping (_ data: UIImage?, _ error: Error?) -> () ) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            DispatchQueue.main.async {
                var image: UIImage?
                if let data = data {
                    image = UIImage(data: data)
                }
                completion(image, error)
            }
        })
        
        task.resume()
        
        return task
    }
    
}
