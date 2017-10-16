//
//  ViewController.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var flowers = [Flower]()
    var selectedIndexPath = IndexPath()
    fileprivate var longPressGesture: UILongPressGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkingService.shared.getFlowers { (response) in
            self.flowers = response.flowers
            self.collectionView.reloadData()
        }
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flowerCell", for: indexPath) as? FlowersGalleryCell else { return UICollectionViewCell() }
        
        cell.configure(with: flowers[indexPath.item])
        
        let flowerImage = cell.flowerImage
        flowerImage?.isHidden = self.selectedIndexPath != indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //MARK: - Display show and hide image in CollectionViewCell
        
        if self.selectedIndexPath == indexPath {
            self.selectedIndexPath = IndexPath()
        }
        else {
            self.selectedIndexPath = indexPath
        }
        self.collectionView.reloadData()
        
        //MARK: - Show alert and convert date
        
        let alertData = flowers[indexPath.row]
        let convertDateFormat = convertDateFormater(date: alertData.releaseDate)
        
        displayAlert(withTitle: alertData.name, andMessage: convertDateFormat)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    //MARK: - Display Alert Method
    
    func displayAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Handle LongGesture to drag and drop image in CollectionViewCell
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            setEditing(true, animated: true)
            startStopWigglingAllVisibleCells()
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
            setEditing(false, animated: false)
            startStopWigglingAllVisibleCells()
        default:
            collectionView.cancelInteractiveMovement()
            
        }
    }
    
    func startStopWigglingAllVisibleCells() {
        let cells = collectionView?.visibleCells as! [FlowersGalleryCell]
        
        for cell in cells {
            if isEditing { cell.startWiggling(element: cell) } else { cell.stopWiggling(element: cell) }
        }
    }

}



