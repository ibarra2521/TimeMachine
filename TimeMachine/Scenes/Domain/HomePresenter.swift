//
//  HomePresenter.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentResponse(response: HomeUseCases.Fetch.Response)
    func presentNClosest(response: HomeUseCases.Algorithm.Response)
}

class HomePresenter: HomePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - HomePresentationLogic Implementations
    func presentResponse(response: HomeUseCases.Fetch.Response) {
        let viewModel = HomeUseCases.Fetch.ViewModel(prize: response.prize)
        viewController?.displayData(viewModel: viewModel)
    }
    
    func presentNClosest(response: HomeUseCases.Algorithm.Response) {
        let viewModel = HomeUseCases.Algorithm.ViewModel(prize: response.prize)
        viewController?.showNClosest(viewModel: viewModel)
    }
}
