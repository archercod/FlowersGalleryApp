//
//  GetFlowersResponse.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

struct GetFlowersResponse {
    
    let flowers: [Flower]
    
    init(json: JSON) throws {
        guard let data = json["flowers"] as? [JSON] else { throw FlowersError.responseError }
        let flowers = data.map{ Flower(json: $0) }.flatMap{ $0 }
        self.flowers = flowers
    }
}
