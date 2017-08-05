#Include Once "ProgressRender.Bi"

Constructor ProgressRender(a As HWND, b As HWND)
	This.handleProgress = a
	This.handleStatus = b
	SendMessage(This.handleProgress,PBM_SETRANGE32,0,256)
	SendMessage(This.handleProgress,PBM_SETBARCOLOR,0,RGB(203,221,241))
End Constructor

Sub ProgressRender.Progress(file As String, n As UINT, nTotal As UINT)
	SendMessage(This.handleProgress,PBM_SETPOS,Cast(Float,n)/nTotal*256,0)
	SetWindowText(This.handleStatus,file)
	' === FOR DEBUG ===[[
	Sleep 500
	' =================]]
End Sub

Sub ProgressRender.Done()
	SetWindowText(This.handleStatus,"¾ÍÐ÷")
End Sub
