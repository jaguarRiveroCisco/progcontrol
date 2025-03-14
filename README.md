# ProgControl

ProgControl is a C++ project designed to manage and monitor processes. It includes custom process and monitor implementations and provides a console interface for interaction.

## Requirements

- CMake 3.30 or higher
- A C++20 compatible compiler (e.g., AppleClang 16.0.0)
- Bash shell

## Project Structure

- `src/progcontrol.cpp`: Main source file for the project.
- `CMakeLists.txt`: CMake configuration file.
- `build.sh`: Shell script to build and install the project.

## Building and Installing

### Build Types

The project supports two build types:

- **Debug**
- **Release**

### Build and Install

To build and install the project, use the `build.sh` script. The script requires two arguments: the build type and the installation path.

```bash
./build.sh <Debug|Release> <path-to-installation>

# Example

./build.sh <Debug|Release> <path-to-installation>

./build.sh Release /Users/jrivero/dev/cloudsec_opi-secure-process-manager/install/
```

## Debugging
The build.sh script prints variable values for debugging purposes.


## CMake Configuration
The CMakeLists.txt file includes the following configurations:


- Sets the C++ standard to C++20.
- Configures include directories based on the installation path.
- Links the SecureProcessManagerLib library.
- Adds installation rules for the executable and libraries.
### Source Code
The main source file src/progcontrol.cpp includes:


- Custom process and monitor implementations.
- Functions to display compilation information.
- Console interface for interaction.

## Usage
After building and installing, you can run the prog_control executable from the installation directory.

```bash
./install/<Debug|Release>/bin/prog_control
```
## License
This project is licensed under the MIT License. See the LICENSE file for details.