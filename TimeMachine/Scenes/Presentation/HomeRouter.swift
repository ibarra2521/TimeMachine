//
//  HomeRouter.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Properties
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
//    // MARK: - Navigation
//    func navigateToSomewhere(source: HomeViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
//
//    // MARK: - Passing data
//    func passDataToSomewhere(source: HomeDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
