//
//  String.swift
//  TimeMachine
//
//  Created by Nick Ibarra on 14/10/19.
//  Copyright © 2019 Nick iOS. All rights reserved.
//

import Foundation

extension String {
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
}
