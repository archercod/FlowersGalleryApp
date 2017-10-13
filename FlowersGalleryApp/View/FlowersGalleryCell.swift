//
//  FlowersGalleryCell.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class FlowersGalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var maskImage: UIImageView!
    
    func configure(with flower: Flower) {
        flower.image { (image) in
            self.flowerImage.image = image
        }
    }
    
    override func prepareForReuse() {
        flowerImage.image = nil
    }
}
