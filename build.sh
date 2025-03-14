#!/usr/bin/env bash

# Check if enough arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <Debug|Release> <path-to-installation>"
  exit 1
fi

# Set the build type and installation path based on arguments
BUILD_TYPE=$1
INSTALL_PATH=$2

# Convert the build type argument to lowercase for easier comparison
BUILD_TYPE_LOWER=$(echo "$BUILD_TYPE" | tr '[:upper:]' '[:lower:]')

# Validate the build type argument
if [[ "$BUILD_TYPE_LOWER" != "debug" && "$BUILD_TYPE_LOWER" != "release" ]]; then
  echo "Invalid build type: $BUILD_TYPE. Use 'Debug' or 'Release'."
  exit 1
fi

# Set the build directory name based on the build type
BUILD_DIR="cmake-build-$BUILD_TYPE_LOWER"
INSTALL_TO="$(pwd)/install/$BUILD_TYPE_LOWER"

# Print variable values for debugging
echo "BUILD_TYPE: $BUILD_TYPE"
echo "INSTALL_PATH: $INSTALL_PATH"
echo "BUILD_TYPE_LOWER: $BUILD_TYPE_LOWER"
echo "BUILD_DIR: $BUILD_DIR"
echo "INSTALL_TO: $INSTALL_TO"

# Run CMake and build the project
cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
  -DINSTALLATION_PATH="$INSTALL_PATH/$BUILD_TYPE_LOWER" -DCMAKE_INSTALL_PREFIX="$INSTALL_TO"

cmake --build "$BUILD_DIR" --target prog_control -j 6

# Test if the build was successful
if [ $? -eq 0 ]; then
  cmake --install "$BUILD_DIR"
  if [ $? -eq 0 ]; then
    echo "Installation completed successfully"
  else
    echo "Installation failed"
    exit 1
  fi
else
  echo "Build failed"
  exit 1
fi