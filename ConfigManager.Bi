#Include Once "windows.bi"

'===================
' 数据删除算法枚举
'===================
Enum ShredAlgorithm
	SA_ZEROALL = 1	'ZeroAll算法
	SA_PSEUDO = 2	'Pseudo算法
	SA_DODC = 3		'DOD C算法
	SA_DODE = 4		'DOD E算法
End Enum

'============
' 默认配置
'============
Const SA_DEFAULT As UINT = ShredAlgorithm.SA_DODE
Const PSEUDOTIMES_DEFAULT As UINT = 5
Const DODCTIMES_DEFAULT As UINT = 5
Const DODEROUNDS_DEFAULT As UINT = 1

Const strIniPath As String = ".\config.ini"
Const appName As String = "ShredFree"

'===============
' 配置数据类型
'===============
Type Config
	algorithm As UINT
	_pseudoTimes As UINT
	_dodCTimes As UINT
	_dodERounds As UINT
End Type

/'========================
 ConfigManager - 配置管理
========================'/
	' 读取配置
	Declare Function ReadConfig() As Config
	' 写入配置
	Declare Sub WriteConfig(config As Config)
	' 取得默认配置
	Declare Function GetDefaultConfig() As Config
	
	' 渲染配置
	Declare Sub RenderConfig(hWin As HWND)
	' 抓取配置
	Declare Function GrabConfig(hWin As HWND) As Config
	