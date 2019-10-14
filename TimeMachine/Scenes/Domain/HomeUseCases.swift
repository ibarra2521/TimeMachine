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
}
