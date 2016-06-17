on sblogin(SSID, loginurl)
	if SSID is "0001softbank" then
		set loginurl to do shell script "echo " & quoted form of loginurl & " | sed s/wrs/wrslogin/"
		do shell script "curl -s -o /dev/null -H 'User-Agent: Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B137 Safari/601.1' --data 'SWSUserName=sbm00683a2%40sbwifi.jp&SWSPassword=JnCZa&doLogin.x=15&doLogin.y=12' " & quoted form of loginurl
	end if
	if SSID is "mobilepoint1" then
		set sblogin to do shell script "echo " & quoted form of sblogin & " | sed s/wrs/wrslogin/"
		do shell script "curl -s -o /dev/null -H 'User-Agent: Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B137 Safari/601.1' --data 'UserName=sbm00683a2&Suffix=sbwifi.jp&Password=JnCZa&button=Login' " & quoted form of sblogin
	end if
end sblogin

on isconnectsuccess()
	set google to do shell script "curl -s -o /dev/null -L -w '%{http_code}' 'http://www.google.com/generate_204'"
	if google = "204" then
		display alert "Success" message "Created by Twitter@fengjueming"
		return
	else
		display alert "Login Error"
		return
	end if
end isconnectsuccess

set SSID to do shell script "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'"

if (SSID is "0001softbank") or (SSID is "mobilepoint1") then
	try
		set loginurl to do shell script "curl -s -o /dev/null -L -w '%{url_effective}' 'http://www.google.com/generate_204'"
	on error
		display alert "Can't connect to LoginServer"
		return
	end try
	if loginurl = "http://www.google.com/generate_204" then
		display alert "Logged-in"
		return
	end if
	if loginurl starts with "https://plogin1.pub.w-lan.jp" or "https://www.login4.w-lan.jp" then
		my sblogin(SSID, loginurl)
		my isconnectsuccess()
		return
	end if
	display alert "Error"
	return
else
	display alert "Pleast select 0001softbank/mobilepoint1"
	return
end if
