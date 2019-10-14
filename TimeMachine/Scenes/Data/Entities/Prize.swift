//
//  File.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import Foundation

struct Prize: Codable {
    
    // MARK: - Enum
    enum CodingKeys: String, CodingKey {
        case diedcity
        case borncountry
        case country
        case born
        case location
        case firstname
        case city
        case surname
        case borncity
        case category
        case year
        case diedcountry
        case died
        case id
        case name
        case motivation
        case gender
    }
    
    // MARK: - Properties
    var diedcity: String?
    var borncountry: String?
    var country: String?
    var born: String?
    var location: Location?
    var firstname: String?
    var city: String?
    var surname: String?
    var borncity: String?
    var category: String?
    var year: String?
    var diedcountry: String?
    var died: String?
    var id: Int?
    var name: String?
    var motivation: String?
    var gender: String?
    var cost: Double?
    
    // MARK: - Init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        diedcity = try? container.decodeIfPresent(String.self, forKey: .diedcity)
        borncountry = try? container.decodeIfPresent(String.self, forKey: .borncountry)
        country = try? container.decodeIfPresent(String.self, forKey: .country)
        born = try? container.decodeIfPresent(String.self, forKey: .born)
        location = try? container.decodeIfPresent(Location.self, forKey: .location)
        firstname = try? container.decodeIfPresent(String.self, forKey: .firstname)
        city = try? container.decodeIfPresent(String.self, forKey: .city)
        surname = try? container.decodeIfPresent(String.self, forKey: .surname)
        borncity = try? container.decodeIfPresent(String.self, forKey: .borncity)
        category = try? container.decodeIfPresent(String.self, forKey: .category)
        year = try? container.decodeIfPresent(String.self, forKey: .year)
        diedcountry = try? container.decodeIfPresent(String.self, forKey: .diedcountry)
        died = try? container.decodeIfPresent(String.self, forKey: .died)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        motivation = try? container.decodeIfPresent(String.self, forKey: .motivation)
        gender = try? container.decodeIfPresent(String.self, forKey: .gender)
    }
}
