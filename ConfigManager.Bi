#Include Once "windows.bi"

'===================
' ����ɾ���㷨ö��
'===================
Enum ShredAlgorithm
	SA_ZEROALL = 1	'ZeroAll�㷨
	SA_PSEUDO = 2	'Pseudo�㷨
	SA_DODC = 3		'DOD C�㷨
	SA_DODE = 4		'DOD E�㷨
End Enum

'============
' Ĭ������
'============
Const SA_DEFAULT As UINT = ShredAlgorithm.SA_DODE
Const PSEUDOTIMES_DEFAULT As UINT = 5
Const DODCTIMES_DEFAULT As UINT = 5
Const DODEROUNDS_DEFAULT As UINT = 1

Const strIniPath As String = ".\config.ini"
Const appName As String = "ShredFree"

'===============
' ������������
'===============
Type Config
	algorithm As UINT
	_pseudoTimes As UINT
	_dodCTimes As UINT
	_dodERounds As UINT
End Type

/'========================
 ConfigManager - ���ù���
========================'/
	' ��ȡ����
	Declare Function ReadConfig() As Config
	' д������
	Declare Sub WriteConfig(config As Config)
	' ȡ��Ĭ������
	Declare Function GetDefaultConfig() As Config
	
	' ��Ⱦ����
	Declare Sub RenderConfig(hWin As HWND)
	' ץȡ����
	Declare Function GrabConfig(hWin As HWND) As Config
	