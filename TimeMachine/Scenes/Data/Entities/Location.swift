//
//  Location.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import Foundation

struct Location: Codable {
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    var lat: Double?
    var lng: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try? container.decodeIfPresent(Double.self, forKey: .lat)
        lng = try? container.decodeIfPresent(Double.self, forKey: .lng)
    }
}
