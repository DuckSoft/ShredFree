#Include Once "windows.bi"
#Include Once "win/commctrl.bi"

#Include Once "ShredFree.Bi"
#Include Once "ConfigManager.Bi"
#Include Once "ProgressRender.Bi"
#Include Once "DragdropHelper.Bi"
#Include Once "FileShredder.Bi"

Dim Shared hInstance As HMODULE
Dim Shared renderProgress As ProgressRender Ptr

#Include Once "ConfigManager.Bas"
#Include Once "ProgressRender.Bas"
#Include Once "DragdropHelper.Bas"
#Include Once "FileShredder.Bas"

Declare Function DlgProc(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer
Declare Function DlgProc_MethodConfig(ByVal hWin As HWND, ByVal uMsg As UINT, ByVal wParam As WPARAM, ByVal lParam As LPARAM) As Integer

	hInstance = GetModuleHandle(NULL)
	InitCommonControls()
	DialogBoxParam(hInstance, Cast(ZString Ptr,dlgMain), NULL, @DlgProc, NULL)
	ExitProcess(0)
	End

Function DlgProc(ByVal hWin As HWND,ByVal uMsg As UINT,ByVal wParam As WPARAM,ByVal lParam As LPARAM) As Integer
	Static dragDrop As DragdropHelper Ptr

	Select Case uMsg
		Case WM_INITDIALOG
			renderProgress = New ProgressRender(GetDlgItem(hWin, barProgress), GetDlgItem(hWin, barStatus))
			dragDrop = New DragdropHelper(hWin, ProcPtr(ShredProc))
		Case WM_CLOSE
			Delete dragDrop
			Delete renderProgress
			EndDialog(hWin, 0)
		Case WM_DROPFILES
			dragDrop->OnDragDrop(wParam)
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
			RenderConfig(hWin)
		Case WM_CLOSE
			EndDialog(hWin, 0)
			'
		Case WM_COMMAND
			Dim As Long id = LoWord(wParam)
			Dim As Long event = HiWord(wParam)
			
			Select Case id
				Case cmdExitConfig
					EndDialog(hWin, 0)
				Case cmdSaveSettings
					WriteConfig(GrabConfig(hWin))
					MessageBox(hWin,"设置保存成功！",appName,MB_ICONINFORMATION Or MB_OK)
					RenderConfig(hWin)
				Case cmdDefaultConfig
					WriteConfig(GetDefaultConfig())
					MessageBox(hWin,"已恢复默认设置！",appName,MB_ICONINFORMATION Or MB_OK)
					RenderConfig(hWin)
			End Select
		Case Else
			Return FALSE
			'
	End Select
	Return TRUE

End Function
