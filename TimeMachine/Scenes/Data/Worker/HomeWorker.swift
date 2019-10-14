//
//  HomeWorker.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit

class HomeWorker {
    func fetchingData(completionHandler: @escaping PrizeResponse) {
        NetworkManager.shared.getPrize(completionHandler: { prize in
            completionHandler(prize)
        })
    }
    
    func gettingNClosest(request: HomeUseCases.Algorithm.Request, completionHandler: @escaping PrizeResponse) {
        Algorithm.shared.algorithm(request: request, completionHandler: { prize in
            completionHandler(prize)
        })
    }
}
