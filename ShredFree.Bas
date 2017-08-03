#Include Once "windows.bi"
#Include Once "win/commctrl.bi"
#Include "ShredFree.bi"

Dim Shared hInstance As HMODULE

Declare Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
Declare Function DlgProc_MethodConfig(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer

	hInstance = GetModuleHandle(NULL)
	InitCommonControls()
	DialogBoxParam(hInstance, Cast(ZString Ptr,dlgMain), NULL, @DlgProc, NULL)
	ExitProcess(0)
	End

Function DlgProc(ByVal hWin As HWND,ByVal uMsg As UINT,ByVal wParam As WPARAM,ByVal lParam As LPARAM) As Integer
	Select Case uMsg
		Case WM_INITDIALOG
			'
		Case WM_CLOSE
			EndDialog(hWin, 0)
			'
		Case WM_COMMAND
			Dim As Long id = LoWord(wParam)
			Dim As Long event = HiWord(wParam)
			
			Select Case id
				Case buttonConfig
					DialogBoxParam(hInstance, Cast(ZString Ptr,dlgMethodConfig), NULL, @DlgProc_MethodConfig, NULL)
				Case buttonClose
					EndDialog(hWin, 0)
			End Select
		Case Else
			Return FALSE
			'
	End Select
	Return TRUE

End Function


Function DlgProc_MethodConfig(ByVal hWin As HWND,ByVal uMsg As UINT,ByVal wParam As WPARAM,ByVal lParam As LPARAM) As Integer
	Select Case uMsg
		Case WM_INITDIALOG
			'
		Case WM_CLOSE
			EndDialog(hWin, 0)
			'
		Case WM_COMMAND
			Dim As Long id = LoWord(wParam)
			Dim As Long event = HiWord(wParam)
			
			'Select Case id

			'End Select
		Case Else
			Return FALSE
			'
	End Select
	Return TRUE

End Function
