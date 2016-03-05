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

-- ScreenShot( UNDO )   

-- click!
set playsound to POSIX path of ("/System/Library/Sounds/Pop.aiff")
do shell script ("afplay " & playsound & " > /dev/null 2>&1 &")

set state to ""

try
	tell application "System Events"
		if exists process "iTunes" then
			tell application "iTunes"
				set state to get player state as text
			end tell
		end if
	end tell
end try

-- UNDO
tell application "Notes" to activate
tell application "System Events"
	tell process "Notes"
		if state is "playing" then
			key code 126 using shift down
			key code 51
			delay 0.5
			key code 126 using shift down
			key code 51
		else
			key code 126 using shift down
			key code 51
		end if
	end tell
end tell
