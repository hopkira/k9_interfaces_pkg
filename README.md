# Custom ROS 2 Service Interfaces and Messages for K9
This package contains custom messages and service interfaces that are used to communicate between K9's nodes.

## Services

### Cancel Speech
A simple service with no request payload that returns success (bool) and a message (string).

### Get Brightness
A simple service with no request payload that returns a level between 0 and 1 (float32).

### Lights Control
Takes a an array of int32s that specify the state of the 12 back lights and returns success (bool) and a message (string).

### Set Brightness
Takes a float32 between 0 and 1 to set the brightness of a single light, returning success (bool) and a message (string).

### Speak
Takes a text string, returning success (bool) and a message (string).

### Switch State
A simple service with no request payload that returns an array of 12 booleans that represent the state of the back panel switches, plus a success (bool) and a message (string).

### Generate Utterance
A simple service that takes a string as input and returns a string as output.  This is used to generate a speech utterance based on the input string and the
collected context information.

## Messages

### Context Line
A simple single string message that is used to transmit context information.
