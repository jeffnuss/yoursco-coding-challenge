//
//  YoursCoCodingChallengeTests.swift
//  YoursCoCodingChallengeTests
//
//  Created by Jeff Nuss on 11/9/17.
//  Copyright © 2017 Jeff Nuss. All rights reserved.
//

import XCTest

import YoursCoCodingChallenge

class TrafficLightTests: XCTestCase {
    func testLightColorDefaultsToRed() {
        XCTAssertEqual(StandardTrafficLight().color, .red)
    }
    
    func testTrafficLightCanChangeColors() {
        let trafficLight = StandardTrafficLight()
        
        trafficLight.color = .green
        XCTAssertEqual(trafficLight.color, .green)
        
        trafficLight.color = .yellow
        XCTAssertEqual(trafficLight.color, .yellow)
        
        trafficLight.color = .red
        XCTAssertEqual(trafficLight.color, .red)
    }
    
    func testTurnTrafficLightCanChangeColors() {
        let trafficLight = TurnTrafficLight()
        
        trafficLight.color = .green
        XCTAssertEqual(trafficLight.color, .green)
        
        trafficLight.color = .yellow
        XCTAssertEqual(trafficLight.color, .yellow)
        
        trafficLight.color = .red
        XCTAssertEqual(trafficLight.color, .red)
        
        trafficLight.color = .flashingOrange
        XCTAssertEqual(trafficLight.color, .flashingOrange)
    }
}

class IntersectionTests: XCTestCase {
    func testWhenInitializedIntersectionHas16Lanes() {
        let intersection = Intersection()
        
        XCTAssertEqual(intersection.laneMatrix.reduce(0) { $0 + $1.count }, 16)
    }
}

class LaneTests: XCTestCase {
    func testWhenLightIsNotRedCarsMoveAlong() {
        let trafficLight = StandardTrafficLight()
        var lane = StraightLane(trafficLight: trafficLight, cars: [Car(), Car(), Car()])

        XCTAssertEqual(lane.cars.count, 3)

        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 3)

        trafficLight.color = .green
        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 2)

        trafficLight.color = .yellow
        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 1)

        trafficLight.color = .red
        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 1)

        trafficLight.color = .green
        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 0)

        trafficLight.color = .green
        lane.moveCarAlongIfNotRed()

        XCTAssertEqual(lane.cars.count, 0)
    }
}

class TrafficLightControllerTests: XCTestCase {
    private var trafficLightController = TrafficLightController(trafficLights: [])
    
    override func setUp() {
        self.trafficLightController = TrafficLightController(
            trafficLights: [
                StandardTrafficLight(),
                TurnTrafficLight(),
                StandardTrafficLight(),
                TurnTrafficLight(),
                StandardTrafficLight(),
                TurnTrafficLight(),
                StandardTrafficLight(),
                TurnTrafficLight(),
                ]
        )
    }

    func testWhenInitializedAllLightsAreRed() {
        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }
    
    func testWhenAllLightsAreRedTheFirstTimeAcrossLightsTurnGreen() {
        self.changeTrafficLights(numberOfTimes: 1)
        
        checkTrafficLightsAreEqual(
            expectedColors: [
                .green, .red, .red, .red,
                .green, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen4ChangesHappenCrossLightsAreYellow() {
        self.changeTrafficLights(numberOfTimes: 4)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .yellow, .red, .red, .red,
                .yellow, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen7ChangesHappenCrossLightsAreRed() {
        self.changeTrafficLights(numberOfTimes: 7)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen8ChangesHappenOtherCrossLightsAreGreen() {
        self.changeTrafficLights(numberOfTimes: 8)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .green, .red,
                .red, .red, .green, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen11ChangesHappenOtherCrossLightsAreYellow() {
        self.changeTrafficLights(numberOfTimes: 11)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .yellow, .red,
                .red, .red, .yellow, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen14ChangesHappenOtherCrossLightsAreRed() {
        self.changeTrafficLights(numberOfTimes: 14)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen15ChangesHappenTurnLightsAreGreen() {
        self.changeTrafficLights(numberOfTimes: 15)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .green, .red, .red,
                .red, .green, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen18ChangesHappenTurnLightsAreYellow() {
        self.changeTrafficLights(numberOfTimes: 18)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .yellow, .red, .red,
                .red, .yellow, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen21ChangesHappenTurnLightsAreRed() {
        self.changeTrafficLights(numberOfTimes: 21)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen22ChangesHappenOtherTurnLightsAreGreen() {
        self.changeTrafficLights(numberOfTimes: 22)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .green,
                .red, .red, .red, .green,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen25ChangesHappenOtherTurnLightsAreYellow() {
        self.changeTrafficLights(numberOfTimes: 25)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .yellow,
                .red, .red, .red, .yellow,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen28ChangesHappenOtherTurnLightsAreRed() {
        self.changeTrafficLights(numberOfTimes: 28)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen29ChangesHappenAcrossLightsTurnGreen() {
        self.changeTrafficLights(numberOfTimes: 29)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .green, .red, .red, .red,
                .green, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen32ChangesHappenAcrossLightsTurnYellow() {
        self.changeTrafficLights(numberOfTimes: 32)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .yellow, .red, .red, .red,
                .yellow, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen35ChangesHappenAcrossLightsTurnRed() {
        self.changeTrafficLights(numberOfTimes: 35)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .red, .red,
                .red, .red, .red, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }

    func testWhen36ChangesHappenOtherAcrossLightsTurnGreen() {
        self.changeTrafficLights(numberOfTimes: 36)

        checkTrafficLightsAreEqual(
            expectedColors: [
                .red, .red, .green, .red,
                .red, .red, .green, .red,
                ],
            trafficLights: trafficLightController.trafficLights
        )
    }
    
    private func checkTrafficLightsAreEqual(expectedColors: [TrafficLightColor], trafficLights: [TrafficLight]) {
        for (expectedColor, trafficLight) in zip(expectedColors, trafficLights) {
            XCTAssertEqual(expectedColor, trafficLight.color)
        }
    }

    private func changeTrafficLights(numberOfTimes: Int) {
        for _ in 0..<numberOfTimes {
            self.trafficLightController.changeTrafficLights()
        }
    }
}
