DEFINE CLASS Test_TwoWay as FxuTestCase OF FxuTestCase.prg

	#IF .f.
		LOCAL THIS AS Test_TwoWay OF Test_TwoWay.PRG
	#ENDIF
	
*========================================================================================
Procedure SetUp

*========================================================================================
Procedure TearDown
		
Procedure Test_Formatting
	Local lcJson
	Text to m.lcJson NoShow PRETEXT 2
	{
		"propertyname":"value"
	}
	EndText 
	*
	Local loObject, lcResult, lcExpected
	loObject = nfJsonRead (m.lcJson)
	lcResult = nfJsonCreate (m.loObject)
	lcExpected = Strtran (m.lcJson, Chr(13)+Chr(10))
	This.AssertEquals (m.lcExpected, m.lcResult)
	
*========================================================================================
Procedure Test_ReplacementOfCharacters
	Local lcJson
	* Values ordered alphabetically, because nfJson returns them this way. JSON does 
	* not specify an order.
	Text to m.lcJson NoShow PRETEXT 2
	{
		"ftp://sample.txt":false,
		"http://foo/page1":true
	}
	EndText
	*
	Local loObject, lcResult, lcExpected, loConfig
	loObject = nfJsonRead (m.lcJson, ,@loConfig)
	This.AssertEquals (2, loConfig.FlatFoxProToJsonNameList.Count)
	lcResult = nfJsonCreate (m.loObject,,,,,m.loConfig)
	lcExpected = Strtran (m.lcJson, Chr(13)+Chr(10))
	This.AssertEquals (m.lcExpected, m.lcResult)
	
*========================================================================================
Procedure Test_EmptyArray
	Local lcJson
	* Values ordered alphabetically, because nfJson returns them this way. JSON does 
	* not specify an order.
	Text to m.lcJson NoShow PRETEXT 2
	{
		"aTest":[]
	}
	EndText
	*
	Local loObject, lcResult, lcExpected, loConfig
	loObject = nfJsonRead (m.lcJson, ,@loConfig)
	lcResult = nfJsonCreate (m.loObject,,,,,m.loConfig)
	lcExpected = Strtran (m.lcJson, Chr(13)+Chr(10))
	This.AssertEquals (m.lcExpected, m.lcResult)

EndDefine