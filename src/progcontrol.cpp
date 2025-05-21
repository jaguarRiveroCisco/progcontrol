
#include "api/logapi.h"
#include "api/pmapi.h"
#include "consolecontroller/console.h"

#include "process/process.h"
#include "processmonitors/process_monitor.h"
struct CustomMonitor final : process::ProcessMonitor
{
};

struct CustomProcess final : process::Process
{

};


void displayCompilationInfo(const char *appName)
{
    std::cout << "*******************************************" << std::endl;
    std::cout << "*                                         *" << std::endl;
    std::cout << "*  Application Name: " << appName << std::endl;
    std::cout << "*  Compiled on: " << __DATE__ << " at " << __TIME__ << std::endl;
    std::cout << "*                                         *" << std::endl;
    std::cout << "*******************************************" << std::endl;
}

auto main(int argc, char *argv[]) -> int
{
    Log::init("console");

    displayCompilationInfo(argv[0]);

    int         numProcesses = 4;
    std::string processType  = "custom";
    static tools::ConsoleLogger cl;

    cli::driver::parseArguments(argc, argv, numProcesses, processType, cl);

    cli::driver::printContext(numProcesses, processType);

    cli::driver::printCommands(); // Call to printHelp

    // Initialize controller with new type and number of processes
    pmapi::registerHandler<CustomMonitor,CustomProcess>(processType);

    pmapi::configureProcessManagerPool(numProcesses, processType);

    cli::driver::consoleLoop();

    pmapi::execute();

    cli::driver::consoleLoop(false);

    std::this_thread::sleep_for(std::chrono::milliseconds(tools::NapTimeMs::LONG));

    cl.logInfo("[EXITING] Main process exiting");

    return 0;
}
