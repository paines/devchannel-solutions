--words dictionary taken from dict (/usr/share/dict/words on linux or osx+homebrew)

local f = io.open("/usr/share/dict/words", "r")
local dict = { }

-- put all known words in a hash table with value as key
for line in f:lines() do
   dict[line] = line
end
io.close(f)

local givenWord = "somehting"

function xchgCharAtPos(str,pos, c)
   return string.sub(str,1, pos-1) .. c .. string.sub(str,pos+1)
end

function exchangeCharsInStringAtPos(strToChg, pos)
   if strToChg ~= "" and pos >= 0 and pos+1 <= string.len(strToChg) then
      local newString = strToChg
      local char0 = string.sub(newString,pos,pos)
      local char1 = string.sub(newString,pos+1,pos+1)

      newString = xchgCharAtPos(newString, pos, char1)
      newString = xchgCharAtPos(newString, pos+1, char0)

      return newString
   end
   return ""
end


function check_mistyped_word(strToCheck, againstDict)
   --user may have typed in the word wrongly, e.g. exchange ~> exhcange, fast ~> fsat
   --meaning just 2 characters could be misplaced
   if string.len(strToCheck) >= 2 then
      for i=0,string.len(strToCheck) do
	 local str = exchangeCharsInStringAtPos(strToCheck,i)
	 if str == dict[str] then
	    print("did you mean ", str)
	 end
      end
   end


   return false
end

if givenWord ~= dict[givenWord] then
   check_mistyped_word(givenWord, dict)
   --other checking could be e.g.
   --each character on a keyboard(qwertz) is surrounded by neighbours, e.g.
   --a is sourrounded by q,w,s,y or
   --g is surrounded by f,t,h,v
   --so we would add array for each character with his surroundigs and check
   --if user has mistyped a character with a neighbour and check against or dict
else
   print("matches")
end
