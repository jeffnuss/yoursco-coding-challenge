//
//  Lane.swift
//  YoursCoCodingChallenge
//
//  Created by Jeff Nuss on 11/14/17.
//  Copyright © 2017 Jeff Nuss. All rights reserved.
//

import Foundation

protocol Lane {
    var trafficLight: TrafficLight { get }
    var cars: [Car] { get set }
}

extension Lane {
    mutating func addCarRandomly() {
        let carArrivalRate: UInt32 = 10
        let randomNumber = Int(arc4random_uniform(carArrivalRate))

        if randomNumber == 0 {
            self.cars.append(Car())
        }
    }

    mutating func moveCarAlongIfNotRed() {
        if self.trafficLight.color != .red {
            if !self.cars.isEmpty {
                self.cars.removeFirst()
            }
        }
    }
}

struct RightTurnLane: Lane {
    let trafficLight: TrafficLight
    var cars: [Car]
}

struct StraightLane: Lane {
    let trafficLight: TrafficLight
    var cars: [Car]
}

struct LeftTurnLane: Lane {
    let trafficLight: TrafficLight
    var cars: [Car]
}

