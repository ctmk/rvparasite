#pragma once

namespace rvp {
namespace process {

	/*!
	 * @param [in] filename
	 * @param [in] commandLineArguments
	 * @return exit-code
	 * @throw std::runtime_error
	 */
	DWORD boot(const TCHAR *filename, TCHAR *commandLineArguments = TEXT(""));
}
}
