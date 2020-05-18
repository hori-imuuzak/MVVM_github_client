//
//  UIImageViewCache.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func cacheImage(imageUrlString: String) {
        let url = URL(string: imageUrlString)
        
        if let imageFromCache = UIImageView.imageCache.object(forKey: imageUrlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if error != nil {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data!) {
                    self.image = imageToCache
                    
                    UIImageView.imageCache.setObject(imageToCache, forKey: imageUrlString as AnyObject)
                }
            }
        }.resume()
    }
}
