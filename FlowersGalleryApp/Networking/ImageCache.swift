//
//  ImageCache.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

let imageCache = ImageCache()

class ImageCache: NSCache<AnyObject, AnyObject> {
    
    func add(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as AnyObject)
    }
    
    func image(forKey key: String) -> UIImage? {
        guard let image = object(forKey: key as AnyObject) as? UIImage else { return nil }
        return image
    }
}
