//
//  ImagesDownloader.swift
//  SwiftyCompanion
//
//  Created by jdavin on 23/01/2019.
//  Copyright © 2019 Jonathan DAVIN. All rights reserved.
//

import UIKit

let                 imageCache = NSCache<NSString, UIImage>()

extension           UIImageView
{
    private func            loadImageUsingCacheWithUrl(from url: URL,
                                                       completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func            loadImageUsingCacheWithUrlString(urlString: String)
    {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)
        self.loadImageUsingCacheWithUrl(from: url!, completion: { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: String(describing: url!) as NSString)
                    self.image = image
                }
            }
        })
    }
}

