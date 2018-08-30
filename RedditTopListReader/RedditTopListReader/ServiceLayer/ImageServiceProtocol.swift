//
//  ImageServiceProtocol.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(_ url: URL, completion: @escaping (_ data: UIImage?, _ error: Error?) -> () ) -> URLSessionDataTask
}
