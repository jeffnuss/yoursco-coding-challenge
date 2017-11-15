//
//  TrafficLight.swift
//  YoursCoCodingChallenge
//
//  Created by Jeff Nuss on 11/14/17.
//  Copyright © 2017 Jeff Nuss. All rights reserved.
//

import Foundation

protocol TrafficLight: class {
    var color: TrafficLightColor { get set}
    var stateCount: Int { get set }
}

extension TrafficLight {
    var stateHasTimedOut: Bool {
        return self.color != .red && self.stateCount < 3
    }

    func incrementStateCount() {
        self.stateCount += 1
    }

    func cycleToNextColor() {
        switch self.color {
        case .green:
            self.color = .yellow
        case .yellow:
            self.color = .red
        case .red:
            if self is TurnTrafficLight {
                self.color = .red
            } else {
                self.color = .green
            }
        case .flashingOrange:
            self.color = .green

        }
    }
}

class StandardTrafficLight: TrafficLight {
    var color = TrafficLightColor.red {
        didSet {
            if self.color != oldValue {
                self.stateCount = 0
            }
        }
    }
    var stateCount: Int = 0
}

class TurnTrafficLight: TrafficLight {
    var color = TrafficLightColor.red {
        didSet {
            self.stateCount = 0
        }
    }
    var stateCount: Int = 0
}

enum TrafficLightColor {
    case green
    case yellow
    case red
    case flashingOrange
}

