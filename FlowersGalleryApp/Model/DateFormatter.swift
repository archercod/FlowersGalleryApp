//
//  DateFormatter.swift
//  FlowersGalleryApp
//
//  Created by Marcin Pietrzak on 13.10.2017.
//  Copyright © 2017 Marcin Pietrzak. All rights reserved.
//

import Foundation

func convertDateFormater(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    
    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return ""
    }
    
    dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    let timeStamp = dateFormatter.string(from: date)
    
    return timeStamp
}
