# ProgControl

ProgControl is a C++ project designed to manage and monitor processes. It includes custom process and monitor implementations and provides a console interface for interaction.
This guide provides a walkthrough for setting up a new project, `prog_control`, that leverages the `ProcessControllerLib` library. In this example, you'll learn how to extend the `Process` and `ProcessMonitor` classes to create custom process and monitor implementations. It also shows you how to spawn external processes to monitor, specifically those requiring a configuration file.

Notably, the code for extending these classes is straightforward, demonstrating how easily you can build upon the base classes. By overriding or implementing the necessary methods, you can customize the behavior as needed. Otherwise, due to polymorphism, the derived classes will function like standard `Process` and `ProcessMonitor` classes, ensuring seamless integration and behavior consistency.

## Requirements

- CMake 3.30 or higher
- A C++20 compatible compiler (e.g., AppleClang 16.0.0)
- Bash shell
- **Compile the Secure Process Manager Library**: Make sure the library is compiled by running the `build.sh` script in the `ProcessController` directory.
- **Install the Secure Process Manager Library**: Ensure the library is installed by executing the same `build.sh` script in the `ProcessController` directory.
- **Create the Sample Program Directory Structure**: Set up the directory structure for the sample program.
- **Create the Sample Program CMake File**: Create a CMake file for the sample program.
- **Ensure your include and library paths are consistent with the installation directory**. See the CMake file below.

## Get the code

```bash
git clone git@github.com:jaguarRiveroCisco/progcontrol.git
cd progcontrol
```

The most important part is the extension of Process and ProcessMonitor, and the initialization of the controller with the new types.

```cpp

#include "process/process.h"
#include "processmonitors/process_monitor.h"
struct CustomMonitor final : process::ProcessMonitor
{
};

struct CustomProcess final : process::Process
{

};

...
    // Initialize controller with new type and number of processes
    api::registerHandler<CustomMonitor,CustomProcess>(processType);

```

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

### Run the Program

```sh
install/debug/bin/prog_control -t system -n 1 -c ./config.conf
```

## Examples of command line usage of the sample program

```sh
 install/debug/bin/prog_control -l file # logging to file
 install/debug/bin/prog_control -c path/to/ConfigFile.conf -t system -l file

```
### System process configuration file

The system process configuration file specifies the system process executable and its parameters. A sample configuration file might look like this:
```sh
process_file=/Users/jrivero/dev/programs/testprogs/progcontrol/lenghty_process.sh
s=10
v=1
#username=admin
#password=securepassword123
#server=localhost
#port=8080
#database=mydatabase
#max_connections=77
#timeout=33
#log_level=debug

```

## License
This project is licensed under the MIT License. See the LICENSE file for details.