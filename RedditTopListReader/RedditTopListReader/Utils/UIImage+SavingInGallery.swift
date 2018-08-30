//
//  UIImage+SavingInGallery.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import UIKit

extension UIImage {
    func saveInGallery() {
        // Ignoring any errors, as I believe we dont want to fustrate users with any errors due to this functionality
        //        please let me know if I need change and add error handling logic
        UIImageWriteToSavedPhotosAlbum(self, nil, nil, nil);
    }
}
