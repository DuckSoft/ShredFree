#Include "ConfigManager.Bi"

Const strIniPath As String = ".\config.ini"
Const appName As String = "ShredFree"

Function ReadConfig() As Config
	Dim As Config config
	
	With config
		.algorithm = GetPrivateProfileInt(appName,"algorithm",SA_DEFAULT,strIniPath)
		._pseudoTimes = GetPrivateProfileInt(appName,"pseudoTimes",PSEUDOTIMES_DEFAULT,strIniPath)
		._dodCTimes = GetPrivateProfileInt(appName,"dodCTimes",DODCTIMES_DEFAULT,strIniPath)
		._dodERounds = GetPrivateProfileInt(appName,"dodERounds",DODEROUNDS_DEFAULT,strIniPath)
	End With
	
	Return config
End Function


Sub WriteConfig(config As Config)
	With config
		WritePrivateProfileString(appName,"algorithm",Str(.algorithm),strIniPath)
		WritePrivateProfileString(appName,"pseudoTimes",Str(._pseudoTimes),strIniPath)
		WritePrivateProfileString(appName,"dodCTimes",Str(._dodCTimes),strIniPath)
		WritePrivateProfileString(appName,"dodERounds",Str(._dodERounds),strIniPath)
	End With
End Sub

Sub RenderConfig(hWin As HWND)
	' 读取配置
	Dim As Config config = ReadConfig()
	
	With config
		' 获取选择按钮控件句柄
		Dim As HWND radioGroup(1 To 4) = {	_
			GetDlgItem(hWin,radioZeroAll),	_
			GetDlgItem(hWin,radioPseudo),		_
			GetDlgItem(hWin,radioDodC),		_
			GetDlgItem(hWin,radioDodE)			_
		}
		' 渲染至选择按钮
		SendMessage(radioGroup(.algorithm),BM_CLICK,0,0)
		
		
		' 渲染至文本框
		SetDlgItemText(hWin,pseudoTimes,Str(._pseudoTimes))
		SetDlgItemText(hWin,dodCTimes,Str(._dodCTimes))
		SetDlgItemText(hWin,dodERounds,Str(._dodERounds))
	End With
End Sub

Function GrabConfig(hWin As HWND) As Config
	' 抓取配置
	Dim As Config config
	
	With config
		Dim As HWND radioGroup(1 To 4) = {	_
			GetDlgItem(hWin,radioZeroAll),	_
			GetDlgItem(hWin,radioPseudo),		_
			GetDlgItem(hWin,radioDodC),		_
			GetDlgItem(hWin,radioDodE)			_
		}
		
		For i As UINT = 1 To 4
			If SendMessage(radioGroup(i),BM_GETCHECK,0,0) = BST_CHECKED Then
				.algorithm = i
				Exit For
			EndIf
		Next
		
		._pseudoTimes = GetDlgItemInt(hWin,pseudoTimes,NULL,FALSE)
		._dodCTimes = GetDlgItemInt(hWin,dodCTimes,NULL,FALSE)
		._dodERounds = GetDlgItemInt(hWin,dodERounds,NULL,FALSE)
	End With
	
	Return config
End Function

Function GetDefaultConfig() As Config
	Dim As Config config
	
	With config
		.algorithm = SA_DEFAULT
		._pseudoTimes = PSEUDOTIMES_DEFAULT
		._dodCTimes = DODCTIMES_DEFAULT
		._dodERounds = DODEROUNDS_DEFAULT
	End With
	
	Return config
End Function
