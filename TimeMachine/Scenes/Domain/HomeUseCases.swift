//
//  HomeUseCases.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit

enum HomeUseCases {
    
    // MARK: - Use cases
    enum Fetch {
        
        struct Request { }
        
        struct Response {
            let prize: [Prize]
        }
        
        struct ViewModel {
            let prize: [Prize]
        }
    }
    
    // MARK: - Algorithm
    enum Algorithm {
        struct Request {
            let totalPrize: [Prize]
            let year: String
            let latitude: Double
            let longitude: Double
        }
        
        struct Response {
            let prize: [Prize]
        }
        
        struct ViewModel {
            let prize: [Prize]
        }
    }
}
