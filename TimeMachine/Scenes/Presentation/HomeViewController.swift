//
//  HomeViewController.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 12/10/19.
//  Copyright (c) 2019 Nick iOS. All rights reserved.
//

import UIKit
import CoreLocation

protocol HomeDisplayLogic: class {
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    
    struct Constant {
        static let min = 1900
        static let max = 2020
    }
    
    // MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var totalPrize = [Prize]()
    var arrayYear = [[Prize]]()
    
    // MARK: - IBOutlets
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
}

// MARK: - Extensions
extension HomeViewController {
    // MARK: -
    func loadData() {
        let request = HomeUseCases.Fetch.Request()
        interactor?.doFetch(request: request)
    }

    // MARK: - Implemented HomeDisplayLogic protocol
    func displayData(viewModel: HomeUseCases.Fetch.ViewModel) {
        print("final step viewModel: \(viewModel.prize.count)")
        //print("final step viewModel: \(viewModel.prize)")
        totalPrize = viewModel.prize
        algorithm()
    }
}

extension HomeViewController {
    func algorithm() {
        let year = "2010"//Int("2010")
        let yearInt = Int("\(year)")
        let latitude = 52.2042666
        let longitude = 0.1149085
        
        arrayYear = getArrayByYear(yearInt ?? 0)
        for (idx, var year) in arrayYear.enumerated() {
            for (index, prize) in year.enumerated() {
                let loc = prize.location
                guard let lat = loc?.lat, let long = loc?.lng else { return }
                let distance = getDistance(origin: CLLocation(latitude: latitude, longitude: longitude), destination: CLLocation(latitude: lat, longitude: long))
                let costDistance = getKmCost(km: distance)
                let yearCost = getYearCost(currentYear: yearInt ?? 0, newYear: Int(prize.year ?? "0") ?? 0)
                year[index].cost = costDistance + yearCost
            }
            arrayYear[idx] = year
        }

        // merged bi array to single array (merged)
        var arrayWithCost = [Prize]()
        arrayYear.forEach { array in
            arrayWithCost.append(contentsOf: array)
        }

        //The algorithm for order
        let arrayOrder = arrayWithCost.sorted { Int($0.cost ?? 0) < Int($1.cost ?? 0) }
        let firstItems = arrayOrder.prefix(20)
        
        // Print the first 20's
        for prize in firstItems {
            print("COST: \(String(describing: prize.cost)) - year: \(String(describing: prize.year)) - category: \(String(describing: prize.category))")
        }
        
    }
    
    func getArrayByYear(filter year: String) -> [Prize] {
        let array = totalPrize.filter { $0.year == year }
        return array
    }
    
    func getDistance(origin: CLLocation, destination: CLLocation) -> Double {
        let kmDistance = origin.distance(from: destination)/1000
        //print("kilometerDistance: \(kmDistance)")
        return kmDistance
    }
    
    func getKmCost(km: Double, defaultCost: Double = 10) -> Double {//let cost = km/defaultCost/2
        km/defaultCost/2
    }
    
    func getYearCost(currentYear: Int, newYear: Int) -> Double {
        if (newYear != currentYear) {
            //let jump = newYear - currentYear
            let jump = Double(abs(newYear - currentYear))
            let cost = jump/2
            //print("cost jumping year: \(cost)")
            return cost
        }
        //print("cost jumping year: \(0.0)")
        return 0.0
    }
    
    func getArrayByYear(_ yearInt: Int) -> [[Prize]] {
        var prizesPerYear = [[Prize]]()
        if isIntoRange(yearInt) {
            var pastTimeYear = yearInt
            var futureTimeYear = yearInt
    
            let array = getArrayByYear(filter: "\(yearInt)")
            if array.count > 0 {
                prizesPerYear.append(array)
            }
            pastTimeYear -= 1
            if isIntoRange(pastTimeYear) {// Back
                while isIntoRange(pastTimeYear) {
                    let arrayPrizeByYear = getArrayByYear(filter: "\(pastTimeYear)")
                    if arrayPrizeByYear.count > 0 {
                        prizesPerYear.append(arrayPrizeByYear)
                    }
                    pastTimeYear -= 1
                }
            }
            futureTimeYear += 1
            if isIntoRange(futureTimeYear) {// Fordward
                while isIntoRange(futureTimeYear) {
                    let arrayPrizeByYear = getArrayByYear(filter: "\(futureTimeYear)")
                    if arrayPrizeByYear.count > 0 {
                        prizesPerYear.append(arrayPrizeByYear)
                    }
                    futureTimeYear += 1
                }
            }
            print("prizesPerYear.count: \(prizesPerYear.count)")
            return prizesPerYear
        }
        return [[]]
    }
    
    func isIntoRange(_ yearInt: Int) -> Bool {
        yearInt >= Constant.min && yearInt <= Constant.max ? true : false
    }
    
}
