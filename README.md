# My Traffic Intersection

This is my simple implementation of a traffic intersection as per the specs found [here](https://github.com/yoursco/interview/blob/master/INTERSECTION.md).

# To Run

The schemes needed to run are included, so to run, simply open the .xcodeproj file in Xcode 9 and run (Product->Run or command-R).

I have also included several tests that can be run as well (Product->Test or command-U). They are in the YoursCoCodingChallengeTests group.

# Implementation Description

This is a simple macOS command line app and as such, it will print all its output to the console. The UI simply outputs the current state of each traffic light as well as how many cars are currently in a given lane.

I implemented the traffic light timer changing the traffic lights from green to yellow and finally to red each second. Cars are modeled by an array that the various lanes of the intersection has. Cars arrive randomly to each lane, with a 1/10 chance of a new car arriving each time the timer is fired. Cars passing through the intersection is implemented by removing the first car from the lane's list of cars when the light is either green or yellow.

I modeled the traffic lights changing as a simple state machine, where the intersection can be in 1 of 4 different states at each time (top and bottom straight, left and right straight, top and bottom turning, left and right turning) and these states transition from one to another in a set order. Each of these states specifies which lights can be green or yellow while all other lights must remain red. Lights will stay green for 3 seconds, then turn yellow for 3 seconds, and then stay red until their corresponding state is reached again.

I have not yet implemented the flashing orange state for a traffic light, nor have I implemented sensors or the walk button. However, I have designed the program so that these features should be relatively straightforward to add.

## Flashing Orange

I would initially look at implementing this by adding a check on the lanes to see if the lanes across from them have any cars in them. I would probably have the Intersection alert the TrafficLightController that a given lane or lanes have too many cars waiting and the TrafficLightController would then handle the state change.

## Sensors

My thoughts on this implementation are to allow different state changes depending on the number of cars in each lane. Currently, I just cycle through the states in a set order, but that order could be changed based on the number of cars. Logic for lanes that have the same number of cars would also need to be included.

## Walk button

A simple implementation would add another state which could be transitioned to at any time when the button is pressed. It would force all lights to be red for a certain amount of time. Additional states could be added to only force red along the top and bottom or along the left and right sides of the intersection, allowing traffic to flow in the same direction as pedestrians.