#Include Once "FileShredder.Bi"
#Include Once "ConfigManager.Bas"

Dim Shared shredConfig As Config

Sub ShredProc(ByRef filepath As String)
	shredConfig = ReadConfig()
	
	With shredConfig
		Select Case .algorithm
			Case ShredAlgorithm.SA_ZEROALL
				Shred_ZeroAll(filepath)
			Case ShredAlgorithm.SA_PSEUDO
				Shred_Pseudo(filepath, ._pseudoTimes)
			Case ShredAlgorithm.SA_DODC
				Shred_DODC(filepath, ._dodCTimes)
			Case ShredAlgorithm.SA_DODE
				Shred_DODE(filepath, ._dodERounds)
		End Select
	End With
End Sub

Sub Shred_ZeroAll(filepath As String)
	Open filepath For Binary Access Read Write Lock Read Write As #1
	Dim As UByte i = 0
	Put #1, 1, i, Lof(1)
	Close #1
	'Kill filepath
End Sub

Sub Shred_Pseudo(filepath As String, times As UINT)
	Open filepath For Binary Access Read Write Lock Read Write As #1
	
	Randomize
	
	For j As UInteger = 1 To times
		For i As UInteger = 1 To Lof(1)
			Dim As UByte f
			f = Rnd * 256
			Put #1, i, f
		Next i
	Next j
	
	Close #1
	'Kill filepath
End Sub

Sub Shred_DODC(filepath As String, times As UINT)
	Open filepath For Binary Access Read Write Lock Read Write As #1
	Dim As UByte i
	Randomize
	
	For j As UInteger = 1 To times
		i = Rnd * 256
		Put #1, 1, i, Lof(1)
	Next
	
	Close #1
	'Kill filepath
End Sub

Sub Shred_DODE(filepath As String, rounds As UINT)
	
End Sub
