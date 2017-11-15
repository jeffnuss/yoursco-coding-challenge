//
//  Intersection.swift
//  YoursCoCodingChallenge
//
//  Created by Jeff Nuss on 11/9/17.
//  Copyright © 2017 Jeff Nuss. All rights reserved.
//

import Foundation

class Intersection {
    var laneMatrix = [[Lane]]()
    var trafficLightController: TrafficLightController

    private var lanes: [Lane] {
        return self.laneMatrix.flatMap { $0 }
    }

    init() {
        var trafficLights = [TrafficLight]()
        for _ in 0..<4 {
            let trafficLight = StandardTrafficLight()
            let turnTrafficLight = TurnTrafficLight()

            self.laneMatrix.append([
                LeftTurnLane(trafficLight: turnTrafficLight, cars: [Car]()),
                StraightLane(trafficLight: trafficLight, cars: [Car]()),
                StraightLane(trafficLight: trafficLight, cars: [Car]()),
                RightTurnLane(trafficLight: trafficLight, cars: [Car]()),
                ])

            trafficLights.append(trafficLight)
            trafficLights.append(turnTrafficLight)
        }

        self.trafficLightController = TrafficLightController(trafficLights: trafficLights)
    }

    func startRunning() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            self.fireTimer()
        }
    }

    private func fireTimer() {
        self.trafficLightController.changeTrafficLights()
        self.updateLanes()

        var trafficLightsNotOutput = self.trafficLightController.trafficLights

        for lane in self.lanes {
            ouptutTrafficLightInfo(lane: lane, trafficLightsNotOutput: &trafficLightsNotOutput)
            outputLaneInfo(lane)
        }

        print()
    }

    private func updateLanes() {
        // Modify the lanes in place because they're structs
        for (i, intersectionSide) in self.laneMatrix.enumerated() {
            for (j, _) in intersectionSide.enumerated() {
                self.laneMatrix[i][j].addCarRandomly()
                self.laneMatrix[i][j].moveCarAlongIfNotRed()
            }
        }
    }

    private func ouptutTrafficLightInfo(lane: Lane, trafficLightsNotOutput: inout [TrafficLight]) {
        if let index = trafficLightsNotOutput.index(where: {
            return $0 === lane.trafficLight
        }) {
            let trafficLightType = lane.trafficLight is StandardTrafficLight ? "Normal traffic light" : "Left turn traffic light"
            print("\(lane.trafficLight.color)\t\t\t(\(trafficLightType))")

            trafficLightsNotOutput.remove(at: index)
        }
    }

    private func outputLaneInfo(_ lane: Lane) {
        let laneType: String

        if lane is StraightLane {
            laneType = "Straight lane"
        } else if lane is RightTurnLane {
            laneType = "Right turn lane"
        } else if lane is LeftTurnLane {
            laneType = "Left turn lane"
        } else {
            laneType = "Unknown lane type"
        }

        print("\(lane.cars.count)\t\t\t(\(laneType))")
    }
}
