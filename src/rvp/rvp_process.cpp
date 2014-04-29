#include "rvp_process.h"
#include <stdexcept>

namespace rvp {
namespace process {

	DWORD boot(const TCHAR *filename, TCHAR *commandLineArguments)
	{
		STARTUPINFO startupinfo = { 0 };
		GetStartupInfo(&startupinfo);
#ifndef RVP_DEBUG
		startupinfo.wShowWindow = SW_HIDE;
#endif
		PROCESS_INFORMATION processinfo = { 0 };

		{
			const BOOL result = CreateProcess(filename, commandLineArguments, NULL, NULL, TRUE, 0, NULL, NULL, &startupinfo, &processinfo);
			if (result != TRUE) {
				throw std::runtime_error("Failed to create process");
			}
			CloseHandle(processinfo.hThread);
		}

		WaitForSingleObject(processinfo.hProcess, INFINITE);

		DWORD exitcode = 0;
		{
			const BOOL result = GetExitCodeProcess(processinfo.hProcess, &exitcode);
			CloseHandle(processinfo.hProcess);
			if (result != TRUE) {
				throw std::runtime_error("Failed to get exit code");
			}
		}

		return exitcode;
	}

}
}
