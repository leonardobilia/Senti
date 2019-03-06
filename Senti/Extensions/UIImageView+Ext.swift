//
//  UIImageView+Ext.swift
//  Senti
//
//  Created by Leonardo Bilia on 3/4/19.
//  Copyright © 2019 Leonardo Bilia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadAndCacheImage(from urlString: String, key: String) {
        var imageUrlString: String?
        
        let webservice = Services()
        backgroundColor = UIColor.appBaseLight
        imageUrlString = urlString
        image = nil
        
        if let cachedImage = cache.object(forKey: key as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        
        webservice.fetchImageFrom(urlString) { [weak self] (image, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let image = image else { return }
            cache.setObject(image, forKey: key as AnyObject)
            guard imageUrlString == urlString else { return }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    func setupWith(image: UIImage? = nil, contentMode: UIView.ContentMode? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image {
            self.image = image
        }
        
        if let contentMode = contentMode {
            self.contentMode = contentMode
        }
    }
    
    func setupWith(image: UIImage? = nil, contentMode: UIView.ContentMode? = nil, radius: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let image = image {
            self.image = image
        }
        
        if let contentMode = contentMode {
            self.contentMode = contentMode
        }
        
        if let radius = radius {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
}
