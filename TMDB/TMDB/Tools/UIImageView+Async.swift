//
//  UIImageView+Async.swift
//  TMDB
//
//  Created by Veerababu Mulugu on 3/28/22.
//

import UIKit

extension UIImageView {
    private static let cache = NSCache<NSString, UIImage>()
    
    func imageWith(urlString: String, placeholder: String) {
        
        self.image = nil
        if let cachedImage = UIImageView.cache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
        } else if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                guard error == nil else {
                    print("Failed to Load URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = UIImage(named: placeholder)
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            UIImageView.cache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
