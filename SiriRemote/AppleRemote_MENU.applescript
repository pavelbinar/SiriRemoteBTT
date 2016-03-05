(*
The MIT License (MIT)

Copyright (c) 2015 guileschool

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

http://github.com/guileschool/SiriRemoteBTT
*)

-- review a selection track info

set state to "paused"

try
	tell application "System Events"
		if exists process "iTunes" then
			-- PLAY / PAUSE
			tell application "iTunes"
				set state to get player state as text
				if state is "playing" then
					pause
				end if
			end tell
		else
			-- display dialog "iTunes is none"
			return -- ignore
		end if
	end tell
on error
	-- display dialog "Exception occur"
end try


-- get a current volume setting and save it
set savedSettings to get volume settings
-- result: {output volume:43, input volume:35, alert volume:78, output muted:false}
set volume output volume 90
-- click!
--set playsound to POSIX path of ("/System/Library/Sounds/Tink.aiff")
--do shell script ("afplay " & playsound & " > /dev/null 2>&1 &")

-- set a track to loved(heart) on iTunes
on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

try
	tell application "iTunes"
		set aLoved to loved of current track
		set aName to name of current track
		set aArtist to artist of current track
		
		set aName to (do shell script "echo '" & aName & "'| sed 's/[^가-힝a-zA-Z0-9]//g'")
		set aArtist to (do shell script "echo '" & aArtist & "'| sed 's/[^가-힝a-zA-Z0-9]//g'")

		set aName to do shell script "echo " & aName & " | sed 's/^\\([^[:alpha:]가-힣]* \\)\\([.]*\\)/\\2/'"
		-- for Korean
		set aa1 to (do shell script "echo " & aName & " | grep -i '[가-힣]'; echo $?")

		if aa1 ends with "0" then
			if aArtist is not "" then
				set aArtist to aArtist & "의.." -- Artist info is exist
			else
				set aArtist to aArtist & "" -- Artist info none	
			end if
		else
			if aArtist is not "" then
				set aArtist to aArtist & ".." -- Artist info is exist
			else
				set aArtist to aArtist & "" -- Artist info none	
			end if
		end if

		display notification aArtist & aName
	
		if aLoved is true then
			if aa1 ends with "0" then
				do shell script "say -v yuna \"좋아하는 음악입니다...\"" & aArtist & aName & ".. 입니다"
			else
				do shell script "say -v Samantha \"Favorite Song..\"" & aArtist & aName
			end if
		end if
	end tell
end try

-- restore a old volume
set volume output volume (output volume of savedSettings)

-- +30sec 전방 탐색
try
	tell application "iTunes"
		set aLoved to loved of current track
		
		-- restore a old iTunes play status
		if state is "playing" then
			
			if aLoved is false then
				-- iTunes Skip 30
				set player position to (player position + 30)
				play
			else
				play
			end if
			
		end if
		
	end tell
end try
