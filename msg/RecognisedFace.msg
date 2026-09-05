# msg/RecognisedFace.msg

uint32 track_id
string identity
float32 recognition_confidence
bool recognised

# Social metadata loaded from the identity's metadata.json.
# Empty for an unknown/unrecognised face.
string relationship
string preferred_address

vision_msgs/BoundingBox2D bbox

builtin_interfaces/Time first_seen
builtin_interfaces/Time last_seen