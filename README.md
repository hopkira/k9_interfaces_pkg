# Custom ROS 2 Service Interfaces and Messages for K9
This package contains custom messages and service interfaces that are used to communicate between K9's nodes.


### Voice Speak

This bundle converts the Piper voice node to a cancellable, priority-aware ROS 2 action server.

#### Files

- `k9_interfaces_pkg/action/SpeakText.action`
- `k9_system_pkg/k9_system_pkg/voice_action_node.py`
- build/package snippets for both packages

#### Install

Copy the action file:

```bash
cp k9_interfaces_pkg/action/SpeakText.action \
  ~/k9_ws/src/k9_interfaces_pkg/action/SpeakText.action
```

Copy the node:

```bash
cp k9_system_pkg/k9_system_pkg/voice_action_node.py \
  ~/k9_ws/src/k9_system_pkg/k9_system_pkg/voice_action_node.py
chmod +x ~/k9_ws/src/k9_system_pkg/k9_system_pkg/voice_action_node.py
```

Apply the supplied CMakeLists, package.xml and setup.py additions, then build interfaces first:

```bash
cd ~/k9_ws
source /opt/ros/jazzy/setup.bash
colcon build --symlink-install --packages-select k9_interfaces_pkg
source install/setup.bash
colcon build --symlink-install --packages-select k9_system_pkg
source install/setup.bash
```

Run:

```bash
ros2 run k9_system_pkg voice_action
```

#### Test the action

Normal queued speech:

```bash
ros2 action send_goal /voice/speak \
  k9_interfaces_pkg/action/SpeakText \
  "{text: 'Affirmative. Voice action server operational.', owner: 'test', priority: 50, interrupt_lower_priority: false, clear_lower_priority: false}" \
  --feedback
```

High-priority replacement speech:

```bash
ros2 action send_goal /voice/speak \
  k9_interfaces_pkg/action/SpeakText \
  "{text: 'Emergency interruption test.', owner: 'test', priority: 200, interrupt_lower_priority: true, clear_lower_priority: true}" \
  --feedback
```

Use `Ctrl+C` in the action client to request cancellation.

Monitor eye-animation topics:

```bash
ros2 topic echo /voice/is_talking
ros2 topic echo /voice/rms_level
ros2 topic hz /voice/rms_level
```

Legacy interfaces remain available during migration:

```bash
ros2 topic pub --once /voice/tts_input std_msgs/msg/String \
  "{data: 'Legacy queued speech test.'}"

ros2 service call /speak_now k9_interfaces_pkg/srv/Speak \
  "{text: 'Legacy immediate speech test.'}"

ros2 service call /cancel_speech k9_interfaces_pkg/srv/CancelSpeech "{}"
```

#### Behaviour

- One utterance owns the physical speaker at a time.
- Queued goals are ordered by priority, then FIFO within the same priority.
- `interrupt_lower_priority=true` pre-empts an active goal of lower or equal priority.
- `clear_lower_priority=true` removes queued goals of lower or equal priority.
- Client cancellation returns a cancelled action result.
- Server-side pre-emption aborts the replaced action with `interrupted=true`.
- `/voice/is_talking` remains true across a clean pre-emption when the replacement is already queued.
- `/is_talking` is also published by default for compatibility with the current eyes node; set `publish_legacy_is_talking:=false` after migrating it to `/voice/is_talking`.
- `/voice/rms_level` is published for every played Piper chunk and reset to zero at the end.

#### Recommended BT goal settings

General conversation:

```yaml
owner: dialogue
priority: 100
interrupt_lower_priority: true
clear_lower_priority: true
```

Chess setup question:

```yaml
owner: chess_setup
priority: 80
interrupt_lower_priority: false
clear_lower_priority: false
```

Low-priority chess commentary:

```yaml
owner: chess_commentary
priority: 30
interrupt_lower_priority: false
clear_lower_priority: false
```

Emergency handling should cancel the current action goal and also call `/cancel_speech` to clear any unrelated queued legacy/action requests.

### Get Brightness
A simple service with no request payload that returns a level between 0 and 1 (float32).

### Lights Control
Takes a an array of int32s that specify the state of the 12 back lights and returns success (bool) and a message (string).

### Set Brightness
Takes a float32 between 0 and 1 to set the brightness of a single light, returning success (bool) and a message (string).


### Switch State
A simple service with no request payload that returns an array of 12 booleans that represent the state of the back panel switches, plus a success (bool) and a message (string).

### Generate Utterance
A simple service that takes a string as input and returns a string as output.  This is used to generate a speech utterance based on the input string and the
collected context information.

## Messages

### Context Line
A simple single string message that is used to transmit context information.
