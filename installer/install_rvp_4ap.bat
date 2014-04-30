@echo off
@Setlocal
@rem rvp installer which is intended to use rvp in all projects.

@set HOME=%CD%

@echo rvp(rvparasite) �� �C���X�g�[�����܂��B
@echo.
@echo �S�Ẵv���W�F�N�g�� rvp ���g�p���邽�߂̐ݒ���s���܂��B
@echo  * �C���X�g�[���𑱂���ꍇ�� y �������Ă��������B
@echo  * ��߂�ꍇ�͂���ȊO�̃L�[�������ĉ������B
@echo ?

@set /p c=
@if "%c%"=="Y" goto do_install
@if "%c%"=="y" goto do_install
goto abort

:do_install
@echo rvp�̃C���X�g�[�����s���܂��B


:check_rvp
@cd /d %~dp0
@set RVP_INSTALLER=%CD%
@cd ..\
@set RVP=%CD%
@set RVP_DLL=%RVP%\scilexer.dll

@if exist %RVP_DLL% goto chech_rpg
@echo !Error: rvp ��������܂���B
@echo  %RVP_DLL% �����݂��܂���B
goto abort

:chech_rpg
@echo.
@echo ...RPG�c�N�[��VX Ace���C���X�g�[�������t�H���_��T���܂��B
@reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Enterbrain\RPGVXAce" /v ApplicationPath >NUL 2>&1
@if "%ERRORLEVEL%"=="0" goto get_rpg
@echo !Error: RPG�c�N�[��VX Ace��������܂���B
goto abort


:get_rpg
@for /f "TOKENS=1,2,*" %%A IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Enterbrain\RPGVXAce" /v ApplicationPath') do (
	@if "%%A"=="ApplicationPath" set PATH_RPG=%%C
)
@if exist "%PATH_RPG%" (
	@echo  RPG�c�N�[��VX Ace: %PATH_RPG%
	goto check_dll
)
@echo !Error: RPG�c�N�[��VX Ace��������܂���B
@echo  - ���W�X�g���ɐݒ肳��Ă���p�X "%PATH_RPG%" �͑��݂��܂���B
goto abort


:check_dll
@echo.
@echo ...SciLexer.dll��ޔ����܂��B
@if exist "%PATH_RPG%\SciLexer.dll" goto make_dll_dir
@echo !Error: RPG�c�N�[��VX Ace���C���X�g�[������Ă���t�H���_�� SciLexer.dll �����݂��܂���B
@echo  ����rvp���C���X�g�[������Ă���\��������܂��B
goto abort


:make_dll_dir
@if not exist "%PATH_RPG%\SciLexer" goto move_dll
@echo !Error: RPG�c�N�[��VX Ace���C���X�g�[������Ă���t�H���_�Ɋ��� SciLexer �����݂��܂��B
@echo  ����rvp���C���X�g�[������Ă���\��������܂��B
goto abort


:move_dll
@mkdir "%PATH_RPG%\SciLexer"
@move "%PATH_RPG%\SciLexer.dll" "%PATH_RPG%\SciLexer"

:move_rvp
@echo.
@echo ...rvp���R�s�[���܂��B
@copy /B "%RVP_DLL%" "%PATH_RPG%"


goto exit

:abort
@echo.
@echo rvp �̃C���X�g�[���𒆒f���܂����B
@pause

@cd %HOME%
@exit /B 1


:exit
@echo rvp �̃C���X�g�[�����������܂����B
@pause

@cd %HOME%
@exit /B 0
