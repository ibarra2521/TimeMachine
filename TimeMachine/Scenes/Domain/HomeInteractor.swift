//
//  HomeInteractor.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case domainError
    case decodingError
}

typealias PrizeResponseHandler = (_ error: Error?, _ prize: [Prize]?) -> ()
typealias PrizeResponse = (Result<[Prize], NetworkError>) -> ()

protocol HomeBusinessLogic {
    func doFetch(request: HomeUseCases.Fetch.Request)
    func applyAlgorithm(request: HomeUseCases.Algorithm.Request)
}

class HomeInteractor: HomeBusinessLogic {
    
    // MARK: - Properties
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    // MARK: - HomeBusinessLogic implementation
    func doFetch(request: HomeUseCases.Fetch.Request) {
        worker = HomeWorker()
        worker?.fetchingData(completionHandler: { prize in
            switch prize {
            case .success(let prizes):
                let response = HomeUseCases.Fetch.Response(prize: prizes)
                self.presenter?.presentResponse(response: response)
            case .failure:
                print("FAILED")
            }
        })
    }
    
    func applyAlgorithm(request: HomeUseCases.Algorithm.Request) {
        worker = HomeWorker()
        worker?.gettingNClosest(request: request, completionHandler: { prize in
            switch prize {
            case .success(let prizes):
                let response = HomeUseCases.Algorithm.Response(prize: prizes)
                self.presenter?.presentNClosest(response: response)
            case .failure:
                print("FAILED")
            }
        })
    }
}
