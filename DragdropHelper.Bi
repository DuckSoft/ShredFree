#Include Once "windows.bi"
#Include Once "win/shellapi.bi"

Type DRAGDROPCALLBACK As Sub(ByRef As String) 

Declare Sub DragdropEnable(hWin As HWND)
Declare Sub DragdropDisable(hWin As HWND)

Type DragdropHelper
	hWnd As HWND
	DragDropFileHandler As DRAGDROPCALLBACK
	
	Declare Constructor(hWin As HANDLE, fHandler As DRAGDROPCALLBACK)
	Declare Destructor()
	Declare Sub OnDragDrop(ByVal wParam As WPARAM)
End Type
