//
//  NetworkManager.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 14/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getPrize(completionHandler: @escaping PrizeResponse) {
        Loading.start()
        makeLocalAWebserviceCall(fileName: "nobel-prize-laureates", completion: { (jsonResponse, error) in
            Loading.stop()
            guard let data = jsonResponse else {
                completionHandler(.failure(.domainError))
                return
            }
            do {
                let data = try? JSONDecoder().decode([Prize].self, from: data)
                if let prizeData = data {
                    completionHandler(.success(prizeData))
                } else {
                    completionHandler(.failure(.decodingError))
                }
            }
        })
    }
    
    private func makeLocalAWebserviceCall(fileName: String, completion: @escaping (_ jsonDataResponse: Data?, _ error: Error?) -> ()) {
        if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                completion(data, nil)
            } catch {
                print("Error loading JSON")
                completion(nil, NetworkError.domainError)
            }
        }
    }
}
