#Include "DragdropHelper.Bi"

Constructor DragdropHelper(hWin As HANDLE, fHandler As DRAGDROPCALLBACK)
	This.hWnd = hWin
	DragAcceptFiles(hWin, TRUE)
	This.DragDropFileHandler = fHandler
End Constructor

Destructor DragdropHelper()
	DragAcceptFiles(This.hWnd, FALSE)
End Destructor

Sub DragdropHelper.OnDragDrop(ByVal wParam As WPARAM)
	Dim As UINT filenum = DragQueryFile(Cast(HDROP, wParam), &HFFFFFFFF, NULL, 0)
	Dim As ZString*256 buf
	
	For i As UINT32 = 0 To filenum-1
		DragQueryFile(Cast(HDROP, wParam), i, @buf, 255)
		This.DragDropFileHandler(buf)
	Next
End Sub
