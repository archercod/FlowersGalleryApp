//
//  FlowersError.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 12.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation

enum FlowersError: Error {
    case error
    case serializationError
    case invalidURL
    case responseError
    case noImageData
}
