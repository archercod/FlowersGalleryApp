//
//  NetworkingService.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation
import UIKit
    
class NetworkingService {
        
    static let shared = NetworkingService()
    private init() {}
    
    let session = URLSession.shared
        
    func getFlowers(success successBlock: @escaping (GetFlowersResponse) -> Void) {
            
        let url = URL(string: "https://dl.dropboxusercontent.com/s/8xmgdtanjbg7khb/test.json")
        let string = try! String.init(contentsOf: url!, encoding: .isoLatin1)
        let data = string.data(using: .utf8)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            let getFlowersResponse = try! GetFlowersResponse(json: json as! JSON)
            DispatchQueue.main.async {
                successBlock(getFlowersResponse)
            }
        }
        catch {
            print(FlowersError.serializationError)
        }
        
        
    }
    
    func downloadImage(fromLink link: String, success successBlock: @escaping (UIImage) -> Void ) {
        guard let url = URL(string: link) else { return }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                successBlock(image)
            }
        }.resume()
    }

}
