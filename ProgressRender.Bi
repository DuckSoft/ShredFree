#Include Once "windows.bi"
#Include Once "win/commctrl.bi"

Type ProgressRender
	handleProgress As HWND
	handleStatus As HWND
	
	Declare Constructor(prog As HWND, stat As HWND)
	Declare Sub Progress(file As String, n As UINT, nTotal As UINT)
	Declare Sub Done()
End Type
