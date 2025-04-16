cmake_minimum_required(VERSION 3.30)
project(ProgControl)

set(CMAKE_CXX_STANDARD 20)

# Find Threads package (needed for Threads::Threads target)
find_package(Threads REQUIRED)

# Use the installation path for include and library directories
set(BASE_INCLUDE_DIR ${INSTALLATION_PATH}/include)
set(BASE_LIB_DIR ${INSTALLATION_PATH}/lib)

# Create an executable
add_executable(prog_control src/progcontrol.cpp)

# Include directories specific to the target
target_include_directories(prog_control PRIVATE
                           ${BASE_INCLUDE_DIR}
                           ${BASE_INCLUDE_DIR}/consolecontroller
                           ${BASE_INCLUDE_DIR}/maincontroller
                           ${BASE_INCLUDE_DIR}/processcontroller
                           ${BASE_INCLUDE_DIR}/processmonitors
                           ${BASE_INCLUDE_DIR}/process
                           ${BASE_INCLUDE_DIR}/process/networkprocess
                           ${BASE_INCLUDE_DIR}/process/systemprocess
                           ${BASE_INCLUDE_DIR}/concurrency
                           ${BASE_INCLUDE_DIR}/tools
                           ${BASE_INCLUDE_DIR}/logger
                           ${BASE_INCLUDE_DIR}/networkprocess
                           ${BASE_INCLUDE_DIR}/systemprocess
                           ${BASE_INCLUDE_DIR}/config
                           ${BASE_INCLUDE_DIR}/api
                           )

# Link directories and libraries specific to the target
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.13")
        target_link_directories(prog_control PRIVATE ${BASE_LIB_DIR})
else()
        link_directories(${BASE_LIB_DIR})
endif()

target_link_libraries(prog_control PRIVATE 
                     SecureProcessManagerLib
                     Threads::Threads  # pthread
                     rt                # realtime library for semaphores
                     )

# Add installation rules
install(TARGETS prog_control
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        )

# Add debugging flags for Debug builds
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")

# Add optimization flags for Release builds
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")