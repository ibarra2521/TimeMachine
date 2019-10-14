//
//  Algorithm.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 14/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import CoreLocation

class Algorithm {
                
    var totalPrize = [Prize]()
    static let shared = Algorithm()

    func algorithm(request: HomeUseCases.Algorithm.Request, completionHandler: @escaping PrizeResponse) {
        Loading.start()
        let yearInt = Int("\(request.year)")
        var arrayYear = [[Prize]]()
        self.totalPrize = request.totalPrize
        arrayYear = getArrayByYear(yearInt ?? 0)
        for (idx, var year) in arrayYear.enumerated() {
            for (index, prize) in year.enumerated() {
                let loc = prize.location
                guard let lat = loc?.lat, let long = loc?.lng else { return }
                let distance = getDistance(origin: CLLocation(latitude: request.latitude, longitude: request.longitude), destination: CLLocation(latitude: lat, longitude: long))
                let costDistance = getKmCost(km: distance)
                let yearCost = getYearCost(currentYear: yearInt ?? 0, newYear: Int(prize.year ?? "0") ?? 0)
                year[index].cost = costDistance + yearCost
            }
            arrayYear[idx] = year
        }
        
        var arrayWithCost = [Prize]()
        arrayYear.forEach { array in
            arrayWithCost.append(contentsOf: array)
        }
        
        let arrayOrder = arrayWithCost.sorted { Int($0.cost ?? 0) < Int($1.cost ?? 0) }
        completionHandler(.success(arrayOrder))
        Loading.stop()
    }
    
    func getArrayByYear(filter year: String) -> [Prize] {
        let array = totalPrize.filter { $0.year == year }
        return array
    }
    
    func getDistance(origin: CLLocation, destination: CLLocation) -> Double {
        let kmDistance = origin.distance(from: destination)/1000
        return kmDistance
    }
    
    func getKmCost(km: Double, defaultCost: Double = 10) -> Double {
        km/defaultCost/2
    }
    
    func getYearCost(currentYear: Int, newYear: Int) -> Double {
        if (newYear != currentYear) {
            let jump = Double(abs(newYear - currentYear))
            let cost = jump/2
            return cost
        }
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
            if isIntoRange(pastTimeYear) {
                while isIntoRange(pastTimeYear) {
                    let arrayPrizeByYear = getArrayByYear(filter: "\(pastTimeYear)")
                    if arrayPrizeByYear.count > 0 {
                        prizesPerYear.append(arrayPrizeByYear)
                    }
                    pastTimeYear -= 1
                }
            }
            futureTimeYear += 1
            if isIntoRange(futureTimeYear) {
                while isIntoRange(futureTimeYear) {
                    let arrayPrizeByYear = getArrayByYear(filter: "\(futureTimeYear)")
                    if arrayPrizeByYear.count > 0 {
                        prizesPerYear.append(arrayPrizeByYear)
                    }
                    futureTimeYear += 1
                }
            }
            return prizesPerYear
        }
        return [[]]
    }
    
    func isIntoRange(_ yearInt: Int) -> Bool {
        yearInt >= Constant.min && yearInt <= Constant.max ? true : false
    }
}
