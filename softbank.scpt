set SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"
if SSID is "0001softbank" then
	set sblogin to do shell script "curl -s -o /dev/null -L -w '%{url_effective}' 'http://www.google.com/generate_204'"
	if sblogin = "http://www.google.com/generate_204" then
		display alert "Logged-in"
		quit
	else
		if sblogin starts with "https://plogin1.pub.w-lan.jp" then
			set sblogin to do shell script "echo " & quoted form of sblogin & " | sed s/wrs/wrslogin/"
			do shell script "curl -s -o /dev/null -H 'User-Agent: Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B137 Safari/601.1' --data 'SWSUserName=#UserName#&SWSPassword=#Password#&doLogin.x=84&doLogin.y=9' " & quoted form of sblogin
		else
			display alert "Can't connect to server"
			quit
		end if
	end if
	set google to do shell script "curl -s -o /dev/null -L -w '%{url_effective}' 'http://www.google.com/generate_204'"
	if google = "http://www.google.com/generate_204" then
		display alert "Success" 
		quit
	else
		display alert "Can't connect to server"
		quit
	end if
else
	display alert "Pleast select 0001softbank"
end if
quit
