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

extension FlowersGalleryCell {
    
    func startWiggling(element: UIView) {
        guard element.layer.animation(forKey: "wiggle") == nil else { return }
        guard element.layer.animation(forKey: "bounce") == nil else { return }
        
        let angle = 0.04
        
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        
        wiggle.autoreverses = true
        wiggle.duration = randomInterval(interval: 0.1, variance: 0.025)
        wiggle.repeatCount = Float.infinity
        
        element.layer.add(wiggle, forKey: "wiggle")
        
        let bounce = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounce.values = [4.0, 0.0]
        
        bounce.autoreverses = true
        bounce.duration = randomInterval(interval: 0.12, variance: 0.025)
        bounce.repeatCount = Float.infinity
        
        element.layer.add(bounce, forKey: "bounce")
    }
    
    func stopWiggling(element: UIView) {
        element.layer.removeAllAnimations()
    }
    
    func randomInterval(interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
    
}
