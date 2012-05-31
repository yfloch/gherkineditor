
function endUnitTest()

testLaunched=false

end


function runItest()
testLaunched=true

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:Fixtures_with_params_without_patterns_is_founded')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:a_message_indicating_params_pattern_missing_is_displayed')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:A_BDD_Test_with_good_syntax_is_evaluated')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:a_message_indicating_params_pattern_missing_is_displayed')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:A_documentation_for_the_param_startDate_is_requested')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:The_documentation_for_the_param_startDate_is_displayed')


    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:A_documentation_for_an_unkown_param_is_requested')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:No_documentation_is_not_displayed')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:A_documentation_for_the_param_amount_is_requested')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:The_documentation_for_the_params_amount_is_not_displayed_but_a_message_for_completion_is_displayed')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:Fixtures_are_searched_with_single_existing_keyword')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:A_list_of_fixtures_corresponding_to_one_word_is_returned')
    
    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:Fixtures_are_searched_with_muliple_existing_keyword')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:A_list_of_fixtures_corresponding_to_multiple_word_is_returned')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:Fixtures_are_searched_with_muliple_none_existing_keyword')
    print("-----THEN-----")
    LuaUnit:run('TestLexer:An_empty_list_of_fixture_is_returned')

    print("-----GIVEN-----")
    LuaUnit:run('TestLexer:A_Domain_Test_Specific_Language') 
    print("-----WHEN-----")
    LuaUnit:run('TestLexer:A_BDD_Test_with_good_syntax_is_entered')
    print("-----THEN-----")
    
--~     unfortunatly i should wait for updateui event be fore runing the fixture but i do not know how. You will find the call in the guerkinEditor.lua file ;-)
--~     LuaUnit:run('TestLexer:The_fixtures_and_business_Keyword_are_styled')

    
end



TestLexer = {} --class

    
--~ GIVEN fixture
    function TestLexer:A_Domain_Test_Specific_Language()
        -- set up tests
		props['fixtures']="\on facture à échoir du $startDate au $endDate avec une période de reférence du $startDateRefPeriod au $endDateRefPeriod#la facture est vide#la part variable doit être $amount euros#il ne doit pas y avoir de part fixe au volume du bac $binNumber#le producteur est un producteur principal"
		props['fixturesParamsPatern']="$startDate#%%d%%d/%%d%%d/%%d%%d%%d%%d#la date est au format 21/12/2011|$endDate#%%d%%d/%%d%%d/%%d%%d%%d%%d|$startDateRefPeriod#%%d%%d/%%d%%d/%%d%%d%%d%%d|$endDateRefPeriod#%%d%%d/%%d%%d/%%d%%d%%d%%d#la date de fin au format 21/12/2011|$amount#%%d+%%.%%d%%d" 
		props['guerkinKeywords']="Soit Et Quand Alors" 
		props['businessKeywords']="producteur facture OM CS BIFFLUX libellé A P I C D" 
--~ 		props['fixtures']="\I have entered (\d+) into the calculator#I press (\w+)#the result should be (.*) on the screen#"
--~ 		props['fixturesParamsPatern']="(\d+)#%%d+#a number|(\w+)#" 
--~ 		props['guerkinKeywords']="Given And when Then" 
--~ 		props['businessKeywords']="result calculator" 
    end

    
--~ WHEN    
    
    function TestLexer:A_BDD_Test_with_good_syntax_is_evaluated()
    OnOpen()

    str="Quand on facture à échoir du 01/01/2010 au 01/01/2010 avec une période de reférence du 01/01/2010 au 01/01/2010\
Alors la facture est vide"
    boolIsFix=isThatSentenceaFixture(str)
    boolIsNotCorrectFix=isTheSyntaxOfFixtureWrong(str,fixturesGet("tableLuaPatAndParam"))    
    end

    function TestLexer:A_BDD_Test_with_good_syntax_is_entered()
--~     OnOpen()

    str="Scenario: Remplacement 1 Particulier => identique à un seul bac\
GivenStories: regles_val_essonne.story\
Soit un producteur de type activité P avec une entité facturable prézezezezezsente du 01/01/2011 au 31/08/2011\
Et ayant une fréquence de collecte 1 au 31/08/2011\
Et le producteur est un producteur principal\
!-- commentaire"

--~     str="Soit le producteur est un producteur principal\
--~ Quand on facture à échoir du 01/01/2010 au 01/01/2010 avec une période de reférence du 01/01/2010 au 01/01/2010\
--~ Alors la facture est vide"

    io.output(io.open("facturation.story","w"))
    io.write(str)
    io.close()
    scite.Open("facturation.story")

--~     editor:SetText(str)    
    end

    function TestLexer:Fixtures_are_searched_with_single_existing_keyword()
     res={}
     res=getFixturesByWord("facture")
    
    end
    
    function TestLexer:Fixtures_are_searched_with_muliple_existing_keyword()
     res={}
     res=getFixturesByWord("du de")
        
    end
    
    function TestLexer:Fixtures_are_searched_with_muliple_none_existing_keyword()
     res={}
     res=getFixturesByWord("unkwonw lost")
    end
    


    function TestLexer:A_documentation_for_the_param_startDate_is_requested()
    documentation={}
     documentation['$startDate']=getDocForMyParam('$startDate')
    end
    
    function TestLexer:A_documentation_for_an_unkown_param_is_requested()
    documentation={}
     documentation['$unkwonwParam']=getDocForMyParam('$unkwonwParam')
    end
    
    function TestLexer:A_documentation_for_the_param_amount_is_requested()
    documentation={}
     documentation['$amount']=getDocForMyParam('$amount')
    end
    
    function TestLexer:A_BDD_Test_with_wrong_syntax_is_lexed(s)
        
 
    end

    function TestLexer:Fixtures_with_params_without_patterns_is_founded()
        testErrorMessage=listParamsNotInProp("%$%a+")        
    end    

    
--~ THEN fixture    
    
    
    function TestLexer:The_fixtures_and_business_Keyword_are_styled()
--~     tmp=tmp.."TestLexer:The_and_business_Keyword_are_colored_with_keyword_style"
--~         local clock = os.clock
--~         function sleep(n)  -- seconds
--~   l     ocal t0 = clock()
--~         while clock() - t0 <= n do end
--~         end

--~     while lexertime==nil then
--~     
--~      print("on attend")
--~     
--~     end

     startPos = editor.EndStyled
     print(startPos)
    local i = editor.CurrentPos
    while i < editor.Length do
       style = StyleAt(i)
--~        print("assertEquals(tableStyleByPosition[i] , "..style..")")
        i = i + 1
    end
assertEquals(tableStyleByPosition[0] , 4)
assertEquals(tableStyleByPosition[1] , 4)
assertEquals(tableStyleByPosition[2] , 4)
assertEquals(tableStyleByPosition[3] , 4)
assertEquals(tableStyleByPosition[4] , 4)
assertEquals(tableStyleByPosition[5] , 4)
assertEquals(tableStyleByPosition[6] , 4)
assertEquals(tableStyleByPosition[7] , 4)
assertEquals(tableStyleByPosition[8] , 4)
assertEquals(tableStyleByPosition[9] , 4)
assertEquals(tableStyleByPosition[10] , 4)
assertEquals(tableStyleByPosition[11] , 4)
assertEquals(tableStyleByPosition[12] , 4)
assertEquals(tableStyleByPosition[13] , 4)
assertEquals(tableStyleByPosition[14] , 4)
assertEquals(tableStyleByPosition[15] , 4)
assertEquals(tableStyleByPosition[16] , 4)
assertEquals(tableStyleByPosition[17] , 4)
assertEquals(tableStyleByPosition[18] , 4)
assertEquals(tableStyleByPosition[19] , 4)
assertEquals(tableStyleByPosition[20] , 4)
assertEquals(tableStyleByPosition[21] , 4)
assertEquals(tableStyleByPosition[22] , 4)
assertEquals(tableStyleByPosition[23] , 4)
assertEquals(tableStyleByPosition[24] , 4)
assertEquals(tableStyleByPosition[25] , 4)
assertEquals(tableStyleByPosition[26] , 4)
assertEquals(tableStyleByPosition[27] , 4)
assertEquals(tableStyleByPosition[28] , 4)
assertEquals(tableStyleByPosition[29] , 4)
assertEquals(tableStyleByPosition[30] , 4)
assertEquals(tableStyleByPosition[31] , 4)
assertEquals(tableStyleByPosition[32] , 4)
assertEquals(tableStyleByPosition[33] , 4)
assertEquals(tableStyleByPosition[34] , 4)
assertEquals(tableStyleByPosition[35] , 4)
assertEquals(tableStyleByPosition[36] , 4)
assertEquals(tableStyleByPosition[37] , 4)
assertEquals(tableStyleByPosition[38] , 4)
assertEquals(tableStyleByPosition[39] , 4)
assertEquals(tableStyleByPosition[40] , 4)
assertEquals(tableStyleByPosition[41] , 4)
assertEquals(tableStyleByPosition[42] , 4)
assertEquals(tableStyleByPosition[43] , 4)
assertEquals(tableStyleByPosition[44] , 4)
assertEquals(tableStyleByPosition[45] , 4)
assertEquals(tableStyleByPosition[46] , 4)
assertEquals(tableStyleByPosition[47] , 4)
assertEquals(tableStyleByPosition[48] , 4)
assertEquals(tableStyleByPosition[49] , 4)
assertEquals(tableStyleByPosition[50] , 4)
assertEquals(tableStyleByPosition[51] , 4)
assertEquals(tableStyleByPosition[52] , 4)
assertEquals(tableStyleByPosition[53] , 4)
assertEquals(tableStyleByPosition[54] , 4)
assertEquals(tableStyleByPosition[55] , 4)
assertEquals(tableStyleByPosition[56] , 4)
assertEquals(tableStyleByPosition[57] , 4)
assertEquals(tableStyleByPosition[58] , 4)
assertEquals(tableStyleByPosition[59] , 4)
assertEquals(tableStyleByPosition[60] , 4)
assertEquals(tableStyleByPosition[61] , 4)
assertEquals(tableStyleByPosition[62] , 4)
assertEquals(tableStyleByPosition[63] , 4)
assertEquals(tableStyleByPosition[64] , 4)
assertEquals(tableStyleByPosition[65] , 1)
assertEquals(tableStyleByPosition[66] , 1)
assertEquals(tableStyleByPosition[67] , 1)
assertEquals(tableStyleByPosition[68] , 1)
assertEquals(tableStyleByPosition[69] , 1)
assertEquals(tableStyleByPosition[70] , 1)
assertEquals(tableStyleByPosition[71] , 1)
assertEquals(tableStyleByPosition[72] , 1)
assertEquals(tableStyleByPosition[73] , 1)
assertEquals(tableStyleByPosition[74] , 1)
assertEquals(tableStyleByPosition[75] , 1)
assertEquals(tableStyleByPosition[76] , 1)
assertEquals(tableStyleByPosition[77] , 0)
assertEquals(tableStyleByPosition[78] , 0)
assertEquals(tableStyleByPosition[79] , 1)
assertEquals(tableStyleByPosition[80] , 1)
assertEquals(tableStyleByPosition[81] , 1)
assertEquals(tableStyleByPosition[82] , 1)
assertEquals(tableStyleByPosition[83] , 1)
assertEquals(tableStyleByPosition[84] , 1)
assertEquals(tableStyleByPosition[85] , 0)
assertEquals(tableStyleByPosition[86] , 1)
assertEquals(tableStyleByPosition[87] , 1)
assertEquals(tableStyleByPosition[88] , 1)
assertEquals(tableStyleByPosition[89] , 0)
assertEquals(tableStyleByPosition[90] , 1)
assertEquals(tableStyleByPosition[91] , 1)
assertEquals(tableStyleByPosition[92] , 1)
assertEquals(tableStyleByPosition[93] , 1)
assertEquals(tableStyleByPosition[94] , 1)
assertEquals(tableStyleByPosition[95] , 1)
assertEquals(tableStyleByPosition[96] , 1)
assertEquals(tableStyleByPosition[97] , 0)
assertEquals(tableStyleByPosition[98] , 1)
assertEquals(tableStyleByPosition[99] , 1)
assertEquals(tableStyleByPosition[100] , 1)
assertEquals(tableStyleByPosition[101] , 1)
assertEquals(tableStyleByPosition[102] , 1)
assertEquals(tableStyleByPosition[103] , 0)
assertEquals(tableStyleByPosition[104] , 2)
assertEquals(tableStyleByPosition[105] , 2)
assertEquals(tableStyleByPosition[106] , 2)
assertEquals(tableStyleByPosition[107] , 2)
assertEquals(tableStyleByPosition[108] , 5)
assertEquals(tableStyleByPosition[109] , 5)
assertEquals(tableStyleByPosition[110] , 5)
assertEquals(tableStyleByPosition[111] , 5)
assertEquals(tableStyleByPosition[112] , 5)
assertEquals(tableStyleByPosition[113] , 5)
assertEquals(tableStyleByPosition[114] , 5)
assertEquals(tableStyleByPosition[115] , 5)
assertEquals(tableStyleByPosition[116] , 5)
assertEquals(tableStyleByPosition[117] , 5)
assertEquals(tableStyleByPosition[118] , 5)
assertEquals(tableStyleByPosition[119] , 5)
assertEquals(tableStyleByPosition[120] , 5)
assertEquals(tableStyleByPosition[121] , 5)
assertEquals(tableStyleByPosition[122] , 5)
assertEquals(tableStyleByPosition[123] , 5)
assertEquals(tableStyleByPosition[124] , 5)
assertEquals(tableStyleByPosition[125] , 5)
assertEquals(tableStyleByPosition[126] , 5)
assertEquals(tableStyleByPosition[127] , 5)
assertEquals(tableStyleByPosition[128] , 5)
assertEquals(tableStyleByPosition[129] , 5)
assertEquals(tableStyleByPosition[130] , 5)
assertEquals(tableStyleByPosition[131] , 5)
assertEquals(tableStyleByPosition[132] , 5)
assertEquals(tableStyleByPosition[133] , 5)
assertEquals(tableStyleByPosition[134] , 5)
assertEquals(tableStyleByPosition[135] , 5)
assertEquals(tableStyleByPosition[136] , 5)
assertEquals(tableStyleByPosition[137] , 5)
assertEquals(tableStyleByPosition[138] , 5)
assertEquals(tableStyleByPosition[139] , 5)
assertEquals(tableStyleByPosition[140] , 5)
assertEquals(tableStyleByPosition[141] , 5)
assertEquals(tableStyleByPosition[142] , 5)
assertEquals(tableStyleByPosition[143] , 5)
assertEquals(tableStyleByPosition[144] , 5)
assertEquals(tableStyleByPosition[145] , 5)
assertEquals(tableStyleByPosition[146] , 5)
assertEquals(tableStyleByPosition[147] , 5)
assertEquals(tableStyleByPosition[148] , 5)
assertEquals(tableStyleByPosition[149] , 5)
assertEquals(tableStyleByPosition[150] , 5)
assertEquals(tableStyleByPosition[151] , 5)
assertEquals(tableStyleByPosition[152] , 5)
assertEquals(tableStyleByPosition[153] , 5)
assertEquals(tableStyleByPosition[154] , 5)
assertEquals(tableStyleByPosition[155] , 5)
assertEquals(tableStyleByPosition[156] , 5)
assertEquals(tableStyleByPosition[157] , 5)
assertEquals(tableStyleByPosition[158] , 5)
assertEquals(tableStyleByPosition[159] , 5)
assertEquals(tableStyleByPosition[160] , 5)
assertEquals(tableStyleByPosition[161] , 5)
assertEquals(tableStyleByPosition[162] , 5)
assertEquals(tableStyleByPosition[163] , 5)
assertEquals(tableStyleByPosition[164] , 5)
assertEquals(tableStyleByPosition[165] , 5)
assertEquals(tableStyleByPosition[166] , 5)
assertEquals(tableStyleByPosition[167] , 5)
assertEquals(tableStyleByPosition[168] , 5)
assertEquals(tableStyleByPosition[169] , 5)
assertEquals(tableStyleByPosition[170] , 5)
assertEquals(tableStyleByPosition[171] , 5)
assertEquals(tableStyleByPosition[172] , 5)
assertEquals(tableStyleByPosition[173] , 5)
assertEquals(tableStyleByPosition[174] , 5)
assertEquals(tableStyleByPosition[175] , 5)
assertEquals(tableStyleByPosition[176] , 5)
assertEquals(tableStyleByPosition[177] , 5)
assertEquals(tableStyleByPosition[178] , 5)
assertEquals(tableStyleByPosition[179] , 5)
assertEquals(tableStyleByPosition[180] , 5)
assertEquals(tableStyleByPosition[181] , 5)
assertEquals(tableStyleByPosition[182] , 5)
assertEquals(tableStyleByPosition[183] , 5)
assertEquals(tableStyleByPosition[184] , 5)
assertEquals(tableStyleByPosition[185] , 5)
assertEquals(tableStyleByPosition[186] , 5)
assertEquals(tableStyleByPosition[187] , 5)
assertEquals(tableStyleByPosition[188] , 5)
assertEquals(tableStyleByPosition[189] , 5)
assertEquals(tableStyleByPosition[190] , 5)
assertEquals(tableStyleByPosition[191] , 5)
assertEquals(tableStyleByPosition[192] , 5)
assertEquals(tableStyleByPosition[193] , 5)
assertEquals(tableStyleByPosition[194] , 5)
assertEquals(tableStyleByPosition[195] , 5)
assertEquals(tableStyleByPosition[196] , 5)
assertEquals(tableStyleByPosition[197] , 5)
assertEquals(tableStyleByPosition[198] , 5)
assertEquals(tableStyleByPosition[199] , 5)
assertEquals(tableStyleByPosition[200] , 5)
assertEquals(tableStyleByPosition[201] , 5)
assertEquals(tableStyleByPosition[202] , 5)
assertEquals(tableStyleByPosition[203] , 5)
assertEquals(tableStyleByPosition[204] , 5)
assertEquals(tableStyleByPosition[205] , 5)
assertEquals(tableStyleByPosition[206] , 5)
assertEquals(tableStyleByPosition[207] , 5)
assertEquals(tableStyleByPosition[208] , 5)
assertEquals(tableStyleByPosition[209] , 5)
assertEquals(tableStyleByPosition[210] , 5)
assertEquals(tableStyleByPosition[211] , 5)
assertEquals(tableStyleByPosition[212] , 5)
assertEquals(tableStyleByPosition[213] , 5)
assertEquals(tableStyleByPosition[214] , 5)
assertEquals(tableStyleByPosition[215] , 5)
assertEquals(tableStyleByPosition[216] , 5)
assertEquals(tableStyleByPosition[217] , 5)
assertEquals(tableStyleByPosition[218] , 2)
assertEquals(tableStyleByPosition[219] , 2)
assertEquals(tableStyleByPosition[220] , 5)
assertEquals(tableStyleByPosition[221] , 5)
assertEquals(tableStyleByPosition[222] , 5)
assertEquals(tableStyleByPosition[223] , 5)
assertEquals(tableStyleByPosition[224] , 5)
assertEquals(tableStyleByPosition[225] , 5)
assertEquals(tableStyleByPosition[226] , 5)
assertEquals(tableStyleByPosition[227] , 5)
assertEquals(tableStyleByPosition[228] , 5)
assertEquals(tableStyleByPosition[229] , 5)
assertEquals(tableStyleByPosition[230] , 5)
assertEquals(tableStyleByPosition[231] , 5)
assertEquals(tableStyleByPosition[232] , 5)
assertEquals(tableStyleByPosition[233] , 5)
assertEquals(tableStyleByPosition[234] , 5)
assertEquals(tableStyleByPosition[235] , 5)
assertEquals(tableStyleByPosition[236] , 5)
assertEquals(tableStyleByPosition[237] , 5)
assertEquals(tableStyleByPosition[238] , 5)
assertEquals(tableStyleByPosition[239] , 5)
assertEquals(tableStyleByPosition[240] , 5)
assertEquals(tableStyleByPosition[241] , 5)
assertEquals(tableStyleByPosition[242] , 5)
assertEquals(tableStyleByPosition[243] , 5)
assertEquals(tableStyleByPosition[244] , 5)
assertEquals(tableStyleByPosition[245] , 5)
assertEquals(tableStyleByPosition[246] , 5)
assertEquals(tableStyleByPosition[247] , 5)
assertEquals(tableStyleByPosition[248] , 5)
assertEquals(tableStyleByPosition[249] , 5)
assertEquals(tableStyleByPosition[250] , 5)
assertEquals(tableStyleByPosition[251] , 5)
assertEquals(tableStyleByPosition[252] , 5)
assertEquals(tableStyleByPosition[253] , 5)
assertEquals(tableStyleByPosition[254] , 5)
assertEquals(tableStyleByPosition[255] , 5)
assertEquals(tableStyleByPosition[256] , 5)
assertEquals(tableStyleByPosition[257] , 5)
assertEquals(tableStyleByPosition[258] , 5)
assertEquals(tableStyleByPosition[259] , 5)
assertEquals(tableStyleByPosition[260] , 5)
assertEquals(tableStyleByPosition[261] , 5)
assertEquals(tableStyleByPosition[262] , 5)
assertEquals(tableStyleByPosition[263] , 5)
assertEquals(tableStyleByPosition[264] , 5)
assertEquals(tableStyleByPosition[265] , 5)
assertEquals(tableStyleByPosition[266] , 5)
assertEquals(tableStyleByPosition[267] , 5)
assertEquals(tableStyleByPosition[268] , 5)
assertEquals(tableStyleByPosition[269] , 5)
assertEquals(tableStyleByPosition[270] , 2)
assertEquals(tableStyleByPosition[271] , 2)
assertEquals(tableStyleByPosition[272] , 0)
assertEquals(tableStyleByPosition[273] , 1)
assertEquals(tableStyleByPosition[274] , 1)
assertEquals(tableStyleByPosition[275] , 0)
assertEquals(tableStyleByPosition[276] , 2)
assertEquals(tableStyleByPosition[277] , 2)
assertEquals(tableStyleByPosition[278] , 2)
assertEquals(tableStyleByPosition[279] , 2)
assertEquals(tableStyleByPosition[280] , 2)
assertEquals(tableStyleByPosition[281] , 2)
assertEquals(tableStyleByPosition[282] , 2)
assertEquals(tableStyleByPosition[283] , 2)
assertEquals(tableStyleByPosition[284] , 2)
assertEquals(tableStyleByPosition[285] , 2)
assertEquals(tableStyleByPosition[286] , 0)
assertEquals(tableStyleByPosition[287] , 1)
assertEquals(tableStyleByPosition[288] , 1)
assertEquals(tableStyleByPosition[289] , 1)
assertEquals(tableStyleByPosition[290] , 0)
assertEquals(tableStyleByPosition[291] , 1)
assertEquals(tableStyleByPosition[292] , 1)
assertEquals(tableStyleByPosition[293] , 0)
assertEquals(tableStyleByPosition[294] , 2)
assertEquals(tableStyleByPosition[295] , 2)
assertEquals(tableStyleByPosition[296] , 2)
assertEquals(tableStyleByPosition[297] , 2)
assertEquals(tableStyleByPosition[298] , 2)
assertEquals(tableStyleByPosition[299] , 2)
assertEquals(tableStyleByPosition[300] , 2)
assertEquals(tableStyleByPosition[301] , 2)
assertEquals(tableStyleByPosition[302] , 2)
assertEquals(tableStyleByPosition[303] , 2)
assertEquals(tableStyleByPosition[304] , 0)
assertEquals(tableStyleByPosition[305] , 1)
assertEquals(tableStyleByPosition[306] , 1)
assertEquals(tableStyleByPosition[307] , 1)
assertEquals(tableStyleByPosition[308] , 1)
assertEquals(tableStyleByPosition[309] , 1)
assertEquals(tableStyleByPosition[310] , 1)
assertEquals(tableStyleByPosition[311] , 1)
assertEquals(tableStyleByPosition[312] , 1)
assertEquals(tableStyleByPosition[313] , 1)
assertEquals(tableStyleByPosition[314] , 0)
assertEquals(tableStyleByPosition[315] , 3)
assertEquals(tableStyleByPosition[316] , 3)
assertEquals(tableStyleByPosition[317] , 3)
assertEquals(tableStyleByPosition[318] , 3)
assertEquals(tableStyleByPosition[319] , 3)
assertEquals(tableStyleByPosition[320] , 3)
assertEquals(tableStyleByPosition[321] , 3)
assertEquals(tableStyleByPosition[322] , 3)
assertEquals(tableStyleByPosition[323] , 3)
assertEquals(tableStyleByPosition[324] , 3)
assertEquals(tableStyleByPosition[325] , 3)
assertEquals(tableStyleByPosition[326] , 3)
assertEquals(tableStyleByPosition[327] , 3)
assertEquals(tableStyleByPosition[328] , 3)
assertEquals(tableStyleByPosition[329] , 3)     
 
    end
    

    function TestLexer:a_message_indicating_params_pattern_missing_is_displayed()
     assertEquals(testErrorMessage , "Patern of the param $binNumber is missing")
    end

    function TestLexer:The_Status_of_fixtures_evaluated_are_ok()
     assertEquals(boolIsFix , true)
     assertEquals(boolIsNotCorrectFix , true)
    end
    
    function TestLexer:The_documentation_for_the_param_startDate_is_displayed()
     assertEquals(documentation['$startDate'] , "la date est au format 21/12/2011")
    end

    function TestLexer:No_documentation_is_not_displayed()
     assertEquals(documentation['$unkwonwParam'] , nil )
    end
    
    function TestLexer:The_documentation_for_the_params_amount_is_not_displayed_but_a_message_for_completion_is_displayed()
     assertEquals(documentation['$amount'] , 'Documentation for this param should be added in the properties' )
    end

    function TestLexer:A_list_of_fixtures_corresponding_to_one_word_is_returned()
     assertEquals(res[1],"la facture est vide")
     assertEquals(res[2],"on facture à échoir du $startDate au $endDate avec une période de reférence du $startDateRefPeriod au $endDateRefPeriod")
    end
    
    
    function TestLexer:A_list_of_fixtures_corresponding_to_multiple_word_is_returned()
        assertEquals(res[1],"il ne doit pas y avoir de part fixe au volume du bac $binNumber")
        assertEquals(res[2],"on facture à échoir du $startDate au $endDate avec une période de reférence du $startDateRefPeriod au $endDateRefPeriod")
    end
    
    function TestLexer:An_empty_list_of_fixture_is_returned()
        assertEquals(res[1],nil)
    end
    
    -- class Test

