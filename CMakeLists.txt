cmake_minimum_required(VERSION 3.8)
project(k9_interfaces_pkg)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
# uncomment the following section in order to fill in
# further dependencies manually.
# find_package(<dependency> REQUIRED

find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(builtin_interfaces REQUIRED)
#find_package(audio_common_msgs REQUIRED)
#find_package(cv_bridge REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "action/SpeakText.action"
  "srv/BackLightCmd.srv"  
  "srv/GetBrightness.srv"
  "srv/LightsControl.srv"
  "srv/SetBrightness.srv"
  "srv/SwitchState.srv"
  "srv/GenerateUtterance.srv"
  "srv/GetWeatherProfile.srv"
  "srv/GetGardenTasks.srv"
  "srv/EmptySrv.srv"
  "srv/SetVoiceState.srv"
  "msg/AudioFrame.msg"
  "msg/ContextLine.msg"
  "msg/IntentResult.msg"
  "msg/TrackedFace.msg"
  "msg/TrackedFaceArray.msg"
  DEPENDENCIES
    std_msgs
    sensor_msgs
    builtin_interfaces
    vision_msgs
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  # the following line skips the linter which checks for copyrights
  # comment the line when a copyright and license is added to all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # comment the line when this package is in a git repo and when
  # a copyright and license is added to all source files
  set(ament_cmake_cpplint_FOUND TRUE)
  ament_lint_auto_find_test_dependencies()
endif()

ament_export_dependencies(rosidl_default_runtime)

ament_package()