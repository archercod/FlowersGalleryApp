//
//  Flower.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation
import UIKit

struct Flower {
    
    private let id: String
    private let imageUrl: String
    
    let name: String
    let releaseDate: String
    
    init?(json: JSON) {
        guard let id = json["product_id"] as? String,
            let name = json["name"] as? String,
            let releaseDateString = json["releaseDate"] as? String,
            let imageUrl = json["image_url"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.releaseDate = releaseDateString
        self.imageUrl = imageUrl
    }
    
    func image(completion: @escaping (UIImage) -> Void ) {
        if let image = imageCache.image(forKey: id) {
            completion(image)
        } else {
            NetworkingService.shared.downloadImage(fromLink: imageUrl) { (image) in
                imageCache.add(image, forKey: self.id)
                completion(image)
            }
        }
    }
}
