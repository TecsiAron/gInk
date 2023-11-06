Unicode True
Unicode true
CRCCheck off
ShowInstDetails show
RequestExecutionLevel admin
!define APP_NAME "gInk"
!define DESCRIPTION "gInk"
!define LICENSE_TXT ".\..\license.txt"
!define INSTALLER_NAME ".\..\release.exe"
!define MAIN_APP_EXE "gInk.exe"
!define INSTALL_TYPE "SetShellVarContext all"
!define REG_ROOT "HKLM"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_EXE}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

!define REG_START_MENU "Start Menu Folder"

Var SM_Folder
SetCompressor ZLIB
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
BrandingText "${APP_NAME}"
XPStyle on
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES\gInk"
!include "WordFunc.nsh"
!include "MUI2.nsh"
!insertmacro VersionCompare
!include "x64.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!insertmacro MUI_PAGE_DIRECTORY

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "gInk"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

#!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAIN_APP_EXE}"
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Section -MainProgram
SetOverwrite ifnewer
	SetOutPath "$INSTDIR"
		File ".\..\bin\config_default.ini"
		File ".\..\bin\config.ini"
		File ".\..\bin\gInk.exe"
		File ".\..\bin\gInk.exe.config"
		File ".\..\bin\gInk.pdb"
		File ".\..\bin\hotkeys.ini"
		File ".\..\bin\icon_red.ico"
		File ".\..\bin\icon_white.ico"
		File ".\..\bin\Microsoft.Ink.dll"
		File ".\..\bin\pens.ini"
	SetOutPath "$INSTDIR\lang"
		CreateDirectory "$INSTDIR\lang"
		File ".\..\bin\lang\ar.txt"
		File ".\..\bin\lang\as.txt"
		File ".\..\bin\lang\bn-bd.txt"
		File ".\..\bin\lang\cz.txt"
		File ".\..\bin\lang\de.txt"
		File ".\..\bin\lang\en-us.txt"
		File ".\..\bin\lang\es-latam.txt"
		File ".\..\bin\lang\fa.txt"
		File ".\..\bin\lang\fr.txt"
		File ".\..\bin\lang\hd.txt"
		File ".\..\bin\lang\he.txt"
		File ".\..\bin\lang\hr.txt"
		File ".\..\bin\lang\hu.txt"
		File ".\..\bin\lang\id-in.txt"
		File ".\..\bin\lang\it.txt"
		File ".\..\bin\lang\ja-jp.txt"
		File ".\..\bin\lang\kn.txt"
		File ".\..\bin\lang\ko-kr.txt"
		File ".\..\bin\lang\lt.txt"
		File ".\..\bin\lang\pl.txt"
		File ".\..\bin\lang\pt-br.txt"
		File ".\..\bin\lang\pt.txt"
		File ".\..\bin\lang\ro.txt"
		File ".\..\bin\lang\ru-ru.txt"
		File ".\..\bin\lang\sk.txt"
		File ".\..\bin\lang\th.txt"
		File ".\..\bin\lang\tr.txt"
		File ".\..\bin\lang\zh-cn.txt"
		File ".\..\bin\lang\zh-tw.txt"
SectionEnd
Section -Icons_Reg
SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\uninstall.exe"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif

!ifndef REG_START_MENU
CreateDirectory "$SMPROGRAMS\gInk"
CreateShortCut "$SMPROGRAMS\gInk\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\gInk\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\gInk\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!endif

WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\uninstall.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif
SectionEnd
Section Uninstall
${INSTALL_TYPE}
Delete "$INSTDIR\config_default.ini"
Delete "$INSTDIR\config.ini"
Delete "$INSTDIR\gInk.exe"
Delete "$INSTDIR\gInk.exe.config"
Delete "$INSTDIR\gInk.pdb"
Delete "$INSTDIR\hotkeys.ini"
Delete "$INSTDIR\icon_red.ico"
Delete "$INSTDIR\icon_white.ico"
Delete "$INSTDIR\Microsoft.Ink.dll"
Delete "$INSTDIR\pens.ini"
Delete "$INSTDIR\lang\ar.txt"
Delete "$INSTDIR\lang\as.txt"
Delete "$INSTDIR\lang\bn-bd.txt"
Delete "$INSTDIR\lang\cz.txt"
Delete "$INSTDIR\lang\de.txt"
Delete "$INSTDIR\lang\en-us.txt"
Delete "$INSTDIR\lang\es-latam.txt"
Delete "$INSTDIR\lang\fa.txt"
Delete "$INSTDIR\lang\fr.txt"
Delete "$INSTDIR\lang\hd.txt"
Delete "$INSTDIR\lang\he.txt"
Delete "$INSTDIR\lang\hr.txt"
Delete "$INSTDIR\lang\hu.txt"
Delete "$INSTDIR\lang\id-in.txt"
Delete "$INSTDIR\lang\it.txt"
Delete "$INSTDIR\lang\ja-jp.txt"
Delete "$INSTDIR\lang\kn.txt"
Delete "$INSTDIR\lang\ko-kr.txt"
Delete "$INSTDIR\lang\lt.txt"
Delete "$INSTDIR\lang\pl.txt"
Delete "$INSTDIR\lang\pt-br.txt"
Delete "$INSTDIR\lang\pt.txt"
Delete "$INSTDIR\lang\ro.txt"
Delete "$INSTDIR\lang\ru-ru.txt"
Delete "$INSTDIR\lang\sk.txt"
Delete "$INSTDIR\lang\th.txt"
Delete "$INSTDIR\lang\tr.txt"
Delete "$INSTDIR\lang\zh-cn.txt"
Delete "$INSTDIR\lang\zh-tw.txt"
Delete "$INSTDIR\uninstall.exe"
!ifdef WEB_SITE
Delete "$INSTDIR\${APP_NAME} website.url"
!endif

RmDir "$INSTDIR"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\$SM_Folder"
!endif

!ifndef REG_START_MENU
Delete "$SMPROGRAMS\gInk\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\gInk\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\gInk\${APP_NAME} Website.lnk"
!endif
Delete "$DESKTOP\${APP_NAME}.lnk"

RmDir "$SMPROGRAMS\gInk"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

######################################################################

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
FunctionEnd

######################################################################
