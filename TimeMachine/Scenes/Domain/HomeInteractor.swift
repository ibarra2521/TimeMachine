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
//typealias PrizeResponse = (Result<[Prize], NetworkError>) -> ()
typealias PrizeResponse = (Result<[Prize], NetworkError>) -> ()

protocol HomeBusinessLogic {
    func doFetch(request: HomeUseCases.Fetch.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - Properties
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""
    
    // MARK: -
    func doFetch(request: HomeUseCases.Fetch.Request) {
        worker = HomeWorker()
        //worker?.fetchingData()
        
        //worker?.fetchingData(completionHandler: { (error: Error?, prize: [Prize]?) in
        worker?.fetchingData(completionHandler: { prize in
            switch prize {
            case .success(let prizes):
                //print("prizes almost: \(prizes)")
                let response = HomeUseCases.Fetch.Response(prize: prizes)
                //print("response sending to presenter: \(response)")
                self.presenter?.presentResponse(response: response)
            case .failure:
                print("FAILED")
            }
//            if let error = error {
//                
//            } else if let products = prize {
//                let response = HomeUseCases.Fetch.Response()
//                print("response sending to presenter: \(response)")
//                self.presenter?.presentResponse(response: response)
//            }
        })
    }
}
