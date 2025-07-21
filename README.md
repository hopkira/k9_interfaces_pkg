# Custom ROS 2 Service Interfaces and Messages for K9
This package contains custom messages and service interfaces that are used to communicate between K9's nodes.

## CancelSpeech
A simple service with no request payload that returns success (bool) and a message (string).

## GetBrightness
A simple service with no request payload that returns a level between 0 and 1 (float32).

## LightsControl
Takes a an array of int32s that specify the state of the 12 back lights and returns success (bool) and a message (string).

## SetBrightness
Takes a float32 between 0 and 1 to set the brightness of a single light, returning success (bool) and a message (string).

## Speak
Takes a text string, returning success (bool) and a message (string).

## SwitchState
A simple service with no request payload that returns an array of 12 booleans that represent the state of the back panel switches, plus a success (bool) and a message (string).
