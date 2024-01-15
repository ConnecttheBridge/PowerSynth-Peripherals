;Modern User Interface
;Written by YZ

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
 !define MUI_BMP "$NSIS\Contrib\Graphics\HeaderPowerSynth_Logo.ico"
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\PowerSynth_Logo.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\PowerSynth_Logo.ico"
;--------------------------------
; Custom defines
  !define NAME "PowerSynth"
  !define APPFILE "PowerSynth2-GUI.lnk"
  !define VERSION "2.0.0"
  !define SLUG "${PowerSynth} v${2.0}"
AllowRootDirInstall true

;--------------------------------
;General

  ;Name and file
  Name "PowerSynth"
  OutFile "PowerSynth.exe"
  Unicode True

  ;Default installation folder
  InstallDir "C:\"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\PowerSynth" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Variables

  Var StartMenuFolder

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages
  
  !insertmacro MUI_PAGE_WELCOME
 
  ;!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  
  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\PowerSynth" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder


  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "PowerSynth"
	;InitPluginsDir
 ;SetOutpath "$PLUGINSDIR"
  
  SetOutPath "$INSTDIR"
   File /r "F:\box\Current measurement\PowerSynth2.0"
   ;nsisunz::Unzip "$PLUGINSDIR\PowerSynth2.0.zip" "$INSTDIR"
 	;Pop $0
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\PowerSynth" "" $INSTDIR
 

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\PowerSynth2.0"
	
  RMDir /r $INSTDIR\PowerSynth
  
  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
    
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"
  
  DeleteRegKey /ifempty HKCU "Software\PowerSynth"

SectionEnd
;--------------------------------
; Section - Shortcut

  Section "Desktop Shortcut" DeskShort
    CreateShortCut "$DESKTOP\${NAME}.lnk" "$INSTDIR\${APPFILE}"\
"$INSTDIR\${MUI_ICON}"


  SectionEnd