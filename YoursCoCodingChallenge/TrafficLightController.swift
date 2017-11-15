//
//  TrafficLightController.swift
//  YoursCoCodingChallenge
//
//  Created by Jeff Nuss on 11/14/17.
//  Copyright © 2017 Jeff Nuss. All rights reserved.
//

import Foundation

struct TrafficLightController {
    enum TrafficLightControllerState {
        case bottomTopStraight, leftRightStraight, bottomTopTurning, leftRightTurning

        var nextState: TrafficLightControllerState {
            switch self {
            case .bottomTopStraight:
                return .leftRightStraight
            case .leftRightStraight:
                return .bottomTopTurning
            case .bottomTopTurning:
                return .leftRightTurning
            case .leftRightTurning:
                return .bottomTopStraight
            }
        }
    }

    var trafficLights: [TrafficLight]
    private var currentState: TrafficLightControllerState = .bottomTopStraight
    private lazy var stateTrafficLightMapping: [TrafficLightControllerState: [TrafficLight]] = [
        .bottomTopStraight: [self.trafficLights[0], self.trafficLights[4]],
        .leftRightStraight: [self.trafficLights[2], self.trafficLights[6]],
        .bottomTopTurning: [self.trafficLights[1], self.trafficLights[5]],
        .leftRightTurning: [self.trafficLights[3], self.trafficLights[7]],
        ]

    init(trafficLights: [TrafficLight]) {
        self.trafficLights = trafficLights
    }

    mutating func changeTrafficLights() {
        if let trafficLightsToUpdate = self.stateTrafficLightMapping[self.currentState] {
            self.updateTrafficLights(trafficLightsToUpdate)
        } else {
            fatalError("Missing a state in the stateTrafficLightMapping")
        }

        if self.areAllLightsRed(self.trafficLights) {
            self.currentState = self.currentState.nextState
        }

        for trafficLight in self.trafficLights {
            trafficLight.incrementStateCount()
        }
    }

    private func updateTrafficLights(_ trafficLightsToUpdate: [TrafficLight]) {
        let allLightsAreRed = self.areAllLightsRed(trafficLightsToUpdate)
        let allLightsHaveTimedOut = trafficLightsToUpdate.first { trafficLight in
            return trafficLight.stateHasTimedOut
            } == nil

        if allLightsAreRed {
            for trafficLight in trafficLightsToUpdate {
                trafficLight.color = .green
            }
        } else if allLightsHaveTimedOut {
            for trafficLight in trafficLightsToUpdate {
                trafficLight.cycleToNextColor()
            }
        }
    }

    private func areAllLightsRed(_ trafficLights: [TrafficLight]) -> Bool {
        return trafficLights.first { trafficLight in
            return trafficLight.color != .red
            } == nil
    }
}
