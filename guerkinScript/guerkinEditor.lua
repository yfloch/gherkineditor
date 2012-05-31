--~ /!\ encoding must be consistent for word matching
--~ consult http://blog.valtersboze.com/2008/03/scite-default-encoding-to-utf-8/



--- Show documentation for the param of the current line.
-- For each param, the function will create a field with its documentation
-- the key is the param.
-- It also manage lack of documentation inviting to completion.
-- only params in the properties files are considered

function showParamsForTheCurrentFixture()

local paramsPatern="%$%a+"
local text=editor:GetCurLine()
-- trigger on line/cursor change
--~     style_delay_count = 0
--~     print(key)
    editor.AnnotationVisible = 2
    editor:AnnotationClearAll()
--~         editor:AnnotationSetText(1,"essais")
--~     editor:AnnotationSetVisible(2)

--~      local textToDisplay=s.."\n"..text..line
     local documentation=""
     local textToDisplay=""
     for w in string.gmatch(text, paramsPatern) do
        documentation=getDocForMyParam(w)
       if documentation ~= nil then
        if textToDisplay == "" then
            textToDisplay="[Esc=>close]\n"..w.." : "..documentation
        else
            textToDisplay=textToDisplay.."\n"..w.." : "..documentation
        end
        
--~        else
--~        textToDisplay=textToDisplay.."\n"..w.." : ".."documentation is missing"
       end
     end
--~ 
    local current_pos = editor.CurrentPos
    local line_idx = editor:LineFromPosition(current_pos)
    editor:AnnotationSetText(line_idx-1,textToDisplay)
--~



end



--- Use onKey event to use esc press in order to hide callTip box
--@param key key is the key number

function OnKey(key)
  -- Adjusting styling delays due to user typing.
-- key codes


if os.getenv'HOME' then
 PLATFORM = 'Linux'
else
 PLATFORM = 'not linux'
end

local KEY_UP, KEY_DOWN, KEY_LEFT, KEY_RIGHT, KEY_ENTER
local PLATFORM = 'Linux'
if PLATFORM == 'Linux' then
  KEY_ENTER = 65293
  KEY_TAB = 65289
  KEY_F1 = 65470
  KEY_ESC = 65307
--~   print('linux')
--~   print(key)
else -- Windows
  KEY_ENTER = 13
  KEY_TAB = 9
--~   print('none linux')
end

local paramsPatern="%$%a+"
local text=editor:GetCurLine()
  if key == KEY_F1 and string.find(text, paramsPatern)
  then -- trigger on line/cursor change
--~     style_delay_count = 0
--~     print(key)
    editor.AnnotationVisible = 2
    editor:AnnotationClearAll()
--~         editor:AnnotationSetText(1,"essais")
--~     editor:AnnotationSetVisible(2)

--~      local textToDisplay=s.."\n"..text..line
     local documentation=""
     local textToDisplay=""
     for w in string.gmatch(text, paramsPatern) do
        documentation=getDocForMyParam(w)
       if documentation ~= nil then
        if textToDisplay == "" then
            textToDisplay="[Esc=>close]\n"..w.." : "..documentation
        else
            textToDisplay=textToDisplay.."\n"..w.." : "..documentation
        end
        
--~        else
--~        textToDisplay=textToDisplay.."\n"..w.." : ".."documentation is missing"
       end
     end
--~ 
    local current_pos = editor.CurrentPos
    local line_idx = editor:LineFromPosition(current_pos)
    editor:AnnotationSetText(line_idx-1,textToDisplay)
--~
  elseif key == KEY_ESC
  then 
    editor.AnnotationVisible = 0
    editor:AnnotationClearAll()
  
  end
end


--- this function return all the fixtures corresponding to the word selected
--@param words represent one or more word used for search

function getFixturesByWord(words)


local fixtureForSearch=getPushTableFixture()
local fixtureMatch={}
    for k,v in pairs(fixtureForSearch) do
     fixtureMatchFlag=true
--~      print(v)
        for w in string.gmatch(words, "%S+") do
--~         print(w)
--~         print(string.find(v ,w))
        
                    if string.find(v ,w)==nil then
                     fixtureMatchFlag=false

                    end
        end
        if fixtureMatchFlag==true then
            table.insert(fixtureMatch,v)
        end
    end
 table.sort(fixtureMatch)
--~  table.foreach(fixtureMatch, print)
 return fixtureMatch
 
end




--- this function display the fixtures to the word selected or not found message

function showFixturesSearchedByWord()

--~  determine the postion + inserte one line and set the range as command line
 
 local current_pos = editor.CurrentPos
 local line_idx = editor:LineFromPosition(current_pos)
 local nextline_idx = editor:LineFromPosition(current_pos)+1
 local linestart = editor:PositionFromLine(line_idx)
 local lineend = editor.LineEndPosition[line_idx]
--~   editor:insert(linestart, "\n>>Search by words the fixtures\n>>\n")
--~   print(line_idx+1)
--~   editor.CurrentPos=editor.LineEndPosition[line_idx+2]
--~  find what is typed
--~  local text=editor:GetCurLine()
 props['lineForSearch1']=tostring(line_idx+1)
 props['lineForSearch2']=tostring(line_idx+2)
 
 
 local fixturesToShow=getFixturesByWord(editor:GetSelText())
     local current_pos = editor.CurrentPos
     local line_idx = editor:LineFromPosition(current_pos)
     local textToDisplay="[Esc=>close]\n"
     
 if fixturesToShow[1]~=nil then
     
     local numberOfResult=# fixturesToShow
     numberOfResult=tostring(numberOfResult) 
     textToDisplay=textToDisplay..numberOfResult.." fixture(s) found for \""..editor:GetSelText().."\" \n"
     for k,v in pairs(fixturesToShow) do
      textToDisplay=textToDisplay.."\n"..v
     end
     
--~      textToDisplay=textToDisplay.."something goes wrong\n"
     
 else
    textToDisplay=textToDisplay.."no fixture found"
 end
     editor.AnnotationVisible = 2
     editor:AnnotationClearAll()
     local linestart = editor:PositionFromLine(line_idx)
     editor:InsertText(linestart-2,"\n\nIndicate word(s) of your search:\n>")     
     editor:AnnotationSetText(line_idx+2,textToDisplay)

 
end



--- this function produce the table with key value param documentation
-- @return a table paramWithDocTable
-- @field index is the param
-- @field 1 the documentation or a message "to complete"

function getDocForParams()
         local paramWithDocTableTmp=split(props['fixturesParamsPatern'],"|")
--~          fixTableParamTmp=split(split(props['fixturesParamsPatern']," "),"#")
         local paramWithDocTable={}
         for k,v in pairs(paramWithDocTableTmp) do
--~             print(k..v)
            local tmp={}
--~             tmp[k]=split(v,"#")
--~             for x,y in tmp do
--~              print(x[y])
--~             end
            local tmp=split(v,"#")
--~             print(tmp[1])
--~             print(tmp[2])
--~             print(tmp[3])
--~             paramWithDocTable[tmp[1]]=nil
            if tmp[3] ~= nil then
                paramWithDocTable[tmp[1]]=tmp[3]
--~                 print(paramWithDocTable[tmp[1]])
            else
                paramWithDocTable[tmp[1]]="Documentation for this param should be added in the properties"
            end
         end
         return(paramWithDocTable)
end


--- this function provide the documentation for params
-- @param s is a string with one ore multiple params with sapca as separator
-- @return a table paramWithDocTable
-- @field 1 the documentation or a message "to complete"



function getDocForMyParam(s)
 local paramWithDocTable = getDocForParams()
 
 
 for k,v in pairs(paramWithDocTable) do
--~  print("---")
--~  print(s.."?="..k)
--~  print(k.." documentation "..v)
    if k==s and v ~= nil and v ~="Documentation should be added in the properties" then
--~         docForParamSatus="Documented"
--~         print(docForParamSatus)
        return(paramWithDocTable[s])
--~         break
    elseif k==s and v ~= nil and v =="Documentation should be added in the properties" then
--~         docForParamSatus="Not Documented"
--~         print(docForParamSatus)
        return(paramWithDocTable[s])
    end
 end
--~  print("---")
--~  print(docForParamSatus)
 return(paramWithDocTable[s])

end


--- this function test one string to determine if the begining is a guerkin keyword
-- @param s is the string evaluated

function isThatSentenceaFixture(s)
--~ countLoger("isThatSentenceaFixture")
             for kw in string.gmatch(props['guerkinKeywords'], "%S+") do
                if string.match(s ,"^"..kw.."%s.") then
                 return true
                end
              end
	 return false
end

--- this function test one string to determine if the syntaxe of one sentence
-- does not correpond to an existing fixture
-- @param s is the string evaluated
-- @param TableOfFixtures is the list of fixtures

function isTheSyntaxOfFixtureWrong(s,TableOfFixtures)
--~ countLoger("isTheSyntaxOfFixtureWrong")
--~    print("fixture"..line)
   
   -- removes end-of-line characters in a string
    s=string.gsub(s, "[\r\n]+$", "")

    -- removes guerkinKeywords
    if string.find(s," ") then
	pos=string.find(s," ")+1
	s=string.sub(s,pos)
    end
    
    if TableOfFixtures~=nil then
    for k,v in pairs(TableOfFixtures) do
--~                                              print(s.." | "..v)                                    
        if string.match(s ,v)then
          return false
--~                                              print(s.." | "..v)

--~                                                 print(s.." | "..v)
        end
    end
    else
     print('something goes wrong and it is probably due to an event not managed by the current guerkin editor plugin'..s)
    end
    
    return true
end



--- this function return the style of one char at one pos
-- @param pos is the position of the char evaludted

function StyleAt(pos)
 return math.mod(editor.StyleAt[pos], 128)
end



--- this function determine one param in a fixture 
-- is missing in the docuementation 
-- @param pat is the pattern of params

function listParamsNotInProp(pat)
--~ countLoger("listParamsNotInProp")
     local paramsPatern=pat
     local s=string.gsub(props['fixtures'],"#"," ")
     local paramsFromFixWithDoublon={}
     local paramsFromFix={}
     for w in string.gmatch(s, paramsPatern) do
       table.insert(paramsFromFixWithDoublon,w)
--~        print(w)
     end
      table.sort(paramsFromFixWithDoublon)
      for k,v in pairs(paramsFromFixWithDoublon) do
       if v~=paramsFromFixWithDoublon[k+1] and string.find(props['fixturesParamsPatern'],v)==nil    then
        local message="Patern of the param "..v.." is missing"
--~         print("Patern of the param "..v.." is missing")
        return message
--~ 	print(v)
--~ 	print(string.find(props['fixturesParamsPatern'],v))
--~ 	local resultOfSearch= string.find(props['fixturesParamsPatern'],v)
--~ 	print("result of find  is : "..resultOfSearch.."for the keyword "..v)
       end
      end
    
end



--- this function provide table of fixture 
-- differnet kind of forma are possible 
-- @param fixFormat table => a table with fixtures, tableLuaPat => table of fixture expressed as lua pattern, fixTableLuaPatAndParam the same as tableLuaPat but params are replaced with the corresponding pattern
-- @return the table of fixture in the corresponding format

function fixturesGet(fixFormat)
--~ countLoger("fixturesGet") 
local fixTable = {}
local fixTableLuaPat={}
local fixTableLuaPatAndParam={}
local fixTableParam={}
local fixTableParamTmp={}
    
    fixTable=split(props['fixtures'],"#")
    if fixFormat=="table" then
     return fixTable
    elseif fixFormat=="tableLuaPat" then
         --~  clean the fixture     
         for k,v in pairs(fixTable) do
             -- adding begin and end for strict matching
                linePattern="^"..v.."$"
             -- change space by %s to do before for better perf
                linePattern=string.gsub(linePattern, " ", "%%s")
        --~  print(lineTextFix .."/"..linePattern)
             table.insert(fixTableLuaPat,linePattern)
         end
    return fixTableLuaPat
    elseif fixFormat=="tableLuaPatAndParam" then
         fixTableLuaPatAndParam=fixturesGet("table")
         fixTableParamTmp=split(props['fixturesParamsPatern'],"|")
--~          fixTableParamTmp=split(split(props['fixturesParamsPatern']," "),"#")
         for k,v in pairs(fixTableParamTmp) do            
            table.insert(fixTableParam,split(v,"#"))
         end
        for k,v in pairs(fixTableLuaPatAndParam) do
     
--~  print(k.." : "..v)   
            for l,w in pairs(fixTableParam) do
--~                         for all words of the fixture
--~                         print(v)
--~                         print(w[1])
--~                         print(w[2])
--~                         print(string.gsub(v,"%s"..w[1].."%s"," "..w[2].." "))
                        v=string.gsub(v,"%s"..w[1].."%s"," "..w[2].." ")
--~                         print(v)
--~                          for the first word of the fixture
                    if string.find(v," ")~=nil then
                        firstSpace=string.find(v," ")
                        firstWord=string.sub(v, 0 ,firstSpace)
                            if firstWord==w[1] then
--~                             print(firstWord)
                                v=string.gsub(w[2],"%%%%","%%")..string.sub(v,firstSpace)
                            end
                            
--~                          for the last word in the fixture

                        lastSpace=string.find(string.reverse(v)," ")
                        lastWord=string.sub(v, string.len(v)-lastSpace+2)
                        

                            if lastWord==w[1] then
--~                             print("lastWord match"..w[1].."=>"..w[2])
                                v=string.sub(v,0,string.len(v)-lastSpace+1)..string.gsub(w[2],"%%%%","%%")
                            end
                    end    
            end
            
             -- adding begin and end for strict matching
            v="^"..v.."$"
             -- change space by %s to do before for better perf
            v=string.gsub(v, " ", "%%s")
            fixTableLuaPatAndParam[k]=v
         end
         
         
    return fixTableLuaPatAndParam
    
    end
end


--- this function unsure that data are set some events clear golbal varaibles
-- @return pushTableFixtureLuaPatAndParam


function getPushTableFixtureLuaPatAndParam()

--~          it is a hack
                if pushTableFixtureLuaPatAndParam==nil then
--~                  print("fixTableLuaPatAndParam is null")
                 pushTableFixtureLuaPatAndParam=fixturesGet("tableLuaPatAndParam")
                end 
        return pushTableFixtureLuaPatAndParam
end


--- this function unsure that data are set some events clear golbal varaibles
-- @return pushTableFixture


function getPushTableFixture()

--~          it is a hack
                if pushPushTableFixture==nil then
--~                  print("PushTableFixture is null")
                 pushTableFixture=fixturesGet("table")
                end 
        return pushTableFixture

end



--- this function will prepare the data and add the entry menu
-- @return pushTableFixtureLuaPatAndParam and pushTableFixture

function OnOpen()
listParamsNotInProp("%$%a+")


props['command.10.*']="showParamsForTheCurrentFixture"
props['command.name.10.*']="Find documentation for params"
props['command.shortcut.10.*']="Ctrl+Shift+F1"
props['command.subsystem.10.*']="3"
props['command.mode.10.*']="savebefore:no"


props['command.11.*']="showFixturesSearchedByWord"
props['command.name.11.*']="Find fixtures corresponding to selection"
props['command.subsystem.11.*']="3"
props['command.shortcut.11.*']="Ctrl+Alt+F"
props['command.mode.11.*']="savebefore:no"


end

--- this function occurs for each char typed
-- and will display the autcompletion list


function OnChar(s)
    local fixtureForCompletion=getPushTableFixture()
--~ prepare The Table for completion 
    table.sort(fixtureForCompletion)
    local current_pos = editor.CurrentPos
    local line_idx = editor:LineFromPosition(current_pos)
    local nextline_idx = editor:LineFromPosition(current_pos)+1
    local linestart = editor:PositionFromLine(line_idx)
    local lineend = editor.LineEndPosition[line_idx]
    local linetext =  editor:textrange(linestart, lineend)
    local lineTextWithoutFisrtWord=string.gsub(linetext,"^%w+%s","")
    local lineTextWithoutFisrtWordlenght=string.len(lineTextWithoutFisrtWord)
--~     print(lineTextWithoutFisrtWordlenght)
--~     print(lineTextWithoutFisrtWord)
    
    stringArrayForCompletion=""
    local numberOfFixture=0
     for k,v in pairs(fixtureForCompletion) do
    --~      print(v.."|"..lineTextWithoutFisrtWord)
         if v~=nil and  string.match(v ,"^"..lineTextWithoutFisrtWord)  then
          stringArrayForCompletion=stringArrayForCompletion..v.."\n"
           if numberOfFixture < 15 then
            numberOfFixture=numberOfFixture + 1
           end
         end
     end  
    editor.AutoCSeparator = string.byte("\n")
    editor.AutoCMaxHeight = numberOfFixture +1
--~     print(string.find("",""))
    
    if stringArrayForCompletion~="" and lineTextWithoutFisrtWordlenght > 1 then
        editor:AutoCShow(lineTextWithoutFisrtWordlenght, stringArrayForCompletion)
    end
--~     
end 


--- this function split a string with one pattern separator
-- @param pString the string to split
-- @param pPattern the pattern of separator

function split(pString, pPattern)
--~ countLoger("split")
   local Table = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pPattern
   local last_end = 1
   local s, e, cap = pString:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(Table,cap)
      end
      last_end = e+1
      s, e, cap = pString:find(fpat, last_end)
   end
   if last_end <= #pString then
      cap = pString:sub(last_end)
      table.insert(Table, cap)
   end
   return Table
end


-- -*- coding: utf-8 -*-


--- this function split a string with one pattern separator
-- @param pString the string to split
-- @param pPattern the pattern of separator
-- inspired from http://www.scintilla.org/ScriptLexer.html

function OnStyle(styler)
        local lexertimeBegin=os.clock()
--~ editor:StyleClearAll()
        local S_DEFAULT = 0
        local S_IDENTIFIER = 1
        local S_KEYWORD = 2
        local S_UNICODECOMMENT = 3
        local S_TITLE= 4
        local S_ERROR= 5
        local S_SEARCH= 6
        
        -- identifierCharacters correspond to the "allowed char in your charset"
        local identifierCharacters = "[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZàâçèéêîôùû]+"
--~         lineStart = editor:LineFromPosition(styler.startPos)
--~         lineEnd = editor:LineFromPosition(styler.startPos + styler.lengthDoc)
        local lineStart = 0
        local lineEnd = editor:LineFromPosition(editor.Length)
        local wrongRange={}
        local fixTableLuaPatAndParam={}
        fixTableLuaPatAndParam = getPushTableFixtureLuaPatAndParam()
--~         coupleKeywordStyle=""
        for line=lineStart,lineEnd,1 do
            local lineText = editor:GetLine(line)

            if lineText ~= nil then
            local isFixture=false
            
            local locisThatSentenceaFixture=isThatSentenceaFixture -- declare the global function as local for perf
            
            local isFixture=locisThatSentenceaFixture(lineText) -- check if the line is a fixture and start with a guerkin Keyword

--~ 		if styler.startPos~=0 then
--~ 			print("current line is a fixture = " .. tostring(isFixture).." > " ..lineText)
--~ 		end            

            local locisTheSyntaxOfFixtureWrong=isTheSyntaxOfFixtureWrong -- declare the global function as local for perf

	    
                if isFixture==true then
                
                  local   fixtureKO=locisTheSyntaxOfFixtureWrong(lineText,fixTableLuaPatAndParam) -- check if the syntaxe of the fixture is correct
--~ 			print("isTheSyntaxOfFixtureWrong = " .. tostring(fixtureKO).." > " ..lineText)                    
                        if fixtureKO==true then
                            
                           local  fixtureKoStart=editor:PositionFromLine(line)
                            local fixtureKoEnd=fixtureKoStart+string.len(lineText)
--~                                                 print("Fixture ko :"..line.."|"..fixtureKoStart.."-"..fixtureKoEnd)
                            wrongRange[fixtureKoStart]=fixtureKoEnd -- wrong range is updated with the new value
                        end
                                   

                end
            end
        end
	
--~     print(props['FileName'])
    local filenameLexerLong=props['FileName'].."LexerLong"
--~ 	print(filenameLexerLong)
    if props[filenameLexerLong]=="true" then
	 styler:StartStyling(styler.startPos, editor.LineEndPosition[editor:LineFromPosition(styler.startPos)], styler.initStyle)  -- styler takes too much time so we just lex one line styling event frequency is to high, in order to help style everything
--~      print(editor:LineFromPosition(styler.startPos))
--~      print(editor.LineEndPosition[editor:LineFromPosition(styler.startPos)])
--~      print(styler.lengthDoc)
	else
	 styler:StartStyling(0,  editor.Length, styler.initStyle)  -- styler does not like scroll becasuse of styling event frequency is to high, in order to help style everything
	end
		
        
        while styler:More() do
--~              print(styler:Position())
                -- Exit state if needed
                if styler:State() == S_IDENTIFIER then
                        if not identifierCharacters:find(styler:Current(), 1, true) then
                              local   identifier = styler:Token()
--~                                 tmp=tmp..identifier
                               local  isKeyword=false
                                local kwLog
                                for kw in string.gmatch(props['businessKeywords'], "%S+") do
                                 if kw==identifier then
                                  isKeyword=true
                                  kwLog=kw
                                 end
                                end
                                for kw in string.gmatch(props['guerkinKeywords'], "%S+") do
                                 if kw==identifier then
                                  isKeyword=true
                                  kwLog=kw
                                 end
                                end
                                if   isKeyword==true then
                                        styler:ChangeState(S_KEYWORD)
--~                                         coupleKeywordStyle=coupleKeywordStyle..kwLog.." has style"..S_KEYWORD..", "
--~                                         print(coupleKeywordStyle)
                                        

--~                                         TestLexer:receive_trace(coupleKeywordStyle)

                                end
                        styler:SetState(S_DEFAULT)
                        end
                        elseif styler:State() == S_UNICODECOMMENT or styler:State() == S_TITLE or styler:State() == S_ERROR or styler:State() == S_SEARCH then
                                if styler:AtLineEnd() then
                                        styler:ForwardSetState(S_DEFAULT)
                                end
                        end
                -- Enter state if needed
                if styler:State() == S_DEFAULT then
                        local inWrongRange=false
                        for k,v in pairs(wrongRange) do
                            local pos=styler:Position()
                            if pos>k and pos<v then
                                inWrongRange=true
                            end
                        end
                        if inWrongRange==true then
                                styler:SetState(S_ERROR)
                        elseif styler:Match(props['comment.block.script_story']) then
                                styler:SetState(S_UNICODECOMMENT)
                        elseif styler:Match(props['guerkinStoryTitle']) then
                                styler:SetState(S_TITLE)
                        elseif styler:Match('Indicate word(s) of your search:') then
                                styler:SetState(S_SEARCH)   
                                promptLine=styler:Position()+1
                                print(promptLine)
                        elseif styler:Line(styler:Position())==promptLine then
                                styler:SetState(S_SEARCH)                                
                        elseif identifierCharacters:find(styler:Current(), 1, true) then
                                styler:SetState(S_IDENTIFIER)
                        end
                        
                        
                        
                end
                styler:Forward()
        end
        local   lexertimeEnd=os.clock()
	    local timeSpent= lexertimeEnd - lexertimeBegin
--~         toto=editor.EndStyled
--~         print("EndStyled => ")
--~         print(toto)
        print("Time onstyle => ")
        print(timeSpent)
--~         props['lexerIsSlow']="false"
	    if timeSpent>1 then
    
	     props[filenameLexerLong]="true"
--~ 	  print("lexer is slow")
	    end
        if props['lineForSearch1']~="" then
--~          styler:SetLineState(tonumber(props['lineForSearch1']), 6)
--~          styler:SetLineState(tonumber(props['lineForSearch2']), 6)
        else
         print("no search is set")
        end
        styler:EndStyling()
        lastEvent="Lexing"
    
--~     io.output(io.open("my.txt","w"))
--~     io.write(props['lexerIsSlow'])
--~     io.close()



end

testMode=true

--~ all test can be found at test/unitTest
--~ an entry in scite menu allow you to launch test

if testMode==true then

props['command.12.*']="runItest"
props['command.name.12.*']="Run Unit Test from startup"
props['command.subsystem.12.*']="3"

--~ props['command.name.12.*']="Run Unit Test from startup"



-- Unit testing starts
require('luaunit/luaunit')
require('test/unitTest')



end



        
        
function OnUpdateUI()
 
  if lastEvent=="Lexing" then
--~   UpdateUItime=os.clock()
--~   timeSpent= UpdateUItime - lexertimeEnd
--~         print("Time ui => ")
--~         print(timeSpent)
--~         StyleAt(position)
--~              print(editor.Length)
            tableStyleByPosition={}
            startPos = editor.EndStyled
--~      print(startPos)
    local i = editor.CurrentPos
    while i < editor.Length do
--~        style = StyleAt(i)
       tableStyleByPosition[i]=StyleAt(i)
--~        print("assertEquals(tableStyleByPosition["..i.."] , "..StyleAt(i)..")")
        i = i + 1
    end
          
            if testMode==true and testLanuched==true then
                LuaUnit:run('TestLexer:The_fixtures_and_business_Keyword_are_styled')
                endUnitTest()
            end
    
  end
          lastEvent="uiUpdate"
                local f = props['FileName']    -- e.g 'test'
                local ext = props['FileExt']   -- e.g 'cpp'
                local path = props['FileDir']  -- e.g. '/home/steve/progs'
--~                 print(path.."/"..f.."."..ext)
 
--~          local f = io.popen("ls -l "..path.."/"..f.."."..ext.." |awk '{print $6 $7 }'") -- store the output in a "file"
--~ print( f:read("*a") )    -- print out the "file"'s content

--~  local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." --time-style=full-iso |awk '{print $6 $7 }'", 'r'))
--~  local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." --time-style='+%Y-%m-%d %H:%M:%S' |awk '{print $6 $7 }'", 'r'))
 local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." |awk '{print $6 $7 }'", 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  local FileUpdate=tostring(path)..props['FileName']..tostring(ext)
  local previousFileUpdate="previous"..FileUpdate
  
props[FileUpdate]=s
print("props['"..FileUpdate.."'] : "..props[FileUpdate])

if props[previousFileUpdate]==nil then
print("fileUpdate is empty")
props[previousFileUpdate]=props[FileUpdate]
end

if props[FileUpdate]~=props[previousFileUpdate] then
 print("file was update by an other program")
end

props[previousFileUpdate]=props[FileUpdate]

end
 

function OnSave()
                local f = props['FileName']    -- e.g 'test'
                local ext = props['FileExt']   -- e.g 'cpp'
                local path = props['FileDir']  -- e.g. '/home/steve/progs'
--~                 print(path.."/"..f.."."..ext)
 
--~          local f = io.popen("ls -l "..path.."/"..f.."."..ext.." |awk '{print $6 $7 }'") -- store the output in a "file"
--~ print( f:read("*a") )    -- print out the "file"'s content

--~  local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." --time-style=full-iso |awk '{print $6 $7 }'", 'r'))
--~  local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." --time-style='+%Y-%m-%d %H:%M:%S' |awk '{print $6 $7 }'", 'r'))
 local f = assert(io.popen("ls -l "..path.."/"..f.."."..ext.." |awk '{print $6 $7 }'", 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  local FileUpdate=tostring(path)..props['FileName']..tostring(ext)
  local previousFileUpdate="previous"..FileUpdate
  props[previousFileUpdate]=s

end 
        
function countLoger(s)

io.output(io.open("loger.txt","a"))
io.write("\n"..s)
io.close()


end