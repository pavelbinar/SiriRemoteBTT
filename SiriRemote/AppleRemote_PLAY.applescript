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

-- iTunes PLAY/PAUSE or ScreenFlow recorder RECORD/PAUSE

try
	set is_running_ScreenFlow to is_running("screenflowrecorder")
	tell application "System Events"
		if is_running_ScreenFlow is not true then
			if exists process "iTunes" then
				-- PLAY / PAUSE
				tell application "iTunes"
					set state to get player state
					if state is playing then
						pause
					else
						play
					end if
					return state
				end tell
			end if
		else
		-- RECORD / PAUSE a Screenflow recording
			key code 19 using {command down, option down, shift down}
			tell application "ScreenFlowHelper" to activate
--			tell application "Keyboard Maestro Engine"
--				do script "9F660586-B3A1-4990-B77E-25F09897DD68"
--			end tell
		end if
	end tell
end try

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running
