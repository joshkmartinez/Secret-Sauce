#singleinstance force
setkeydelay 45 ; 

steampath = c:\program files (x86)\steam ; path to the steam folder
RegRead, steampath, HKEY_CURRENT_USER, SOFTWARE\Valve\Steam, SteamPath
launchtf2 = yes ; check the check box "launch tf2" by default (yes or no)
launchoptions = -console -noborder -novid ; launch options for tf2, optional
hacks = yes ; check the check box "hacks" by default (yes or no)
hackpath = ; path to hacks executable
changename = 0 ;
newname = boom ;

show_ip_box = yes ; check the check box "connect to ip address" by default (yes or no)

gui:
gui, destroy
gui, add, edit, 				x90 	y25 	w340 	h21 vahkname, 
gui, add, edit, 				x90 	y56 	w380 	h21 vahkpass, 
gui, add, edit, 				x90 	y194 	w380 	h21 vahkipstring, 
gui, add, edit,					x90 	y225 	w380 	h21 vnewname,
gui, add, edit,					x90		y163	w380	h21	vhackpath,

gui, add, checkbox, 	x90 	y87 	w90 	h13  ghackcheck vahktf2, Launch TF2
gui, add, checkbox, 	x190 	y87 	w90 	h13 ghackcheck vahkhack, Run hacks
gui, add, checkbox, 	x280 	y87 	w200 	h13  vshowbox, Automatically connect to server
gui, add, checkbox, 	x220 	y109 	w100 	h13	vchangename, Change Name?

gui, add, button, 			x439 	y24 	w32 , new
gui, add, button, 			x89 	y131 	w162 , create
gui, add, button, 			x259 	y131 	w162 , cancel

gui, add, text, 					x1 		y28 	w80 	right, Username
gui, add, text, 					x1 		y59 	w80 	right, Password
gui, add, text,						x1 		y163	w80		right, Hack Path
gui, add, text,						x1 		y194	w80		right, Server IP
gui, add, text,						x1 		y225 	w80 	right, Name

gui, add, text,					 	x5      y265    w485	right, Use at your own risk!
gui, show, w495 h280 x5 y5,Enhanced Steam Account Creator

ifnotexist, %steampath%\steam.exe
{
msgbox, Steam is not located where the system registry says it is
exitapp
}
buttonnew:
generatename: ;username
ncharlist = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,1,2,3,4,5,6,7,8,9,0
stringsplit, chararray, ncharlist, `,
nstr =
random, nrand, 8, 16
loop, %nrand%
{       random, pick, 1, %chararray0%
        item := chararray%pick%
        nstr = %nstr%%item%
}
generatemail: ;email address
mcharlist = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
stringsplit, chararray, mcharlist, `,
mstr =
random, mrand, 8, 16
loop, %mrand%
{       random, pick, 1, %chararray0%
        item := chararray%pick%
        mstr = %mstr%%item%
}
generatemailhost: ;email host or whatever
mhcharlist = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
stringsplit, chararray, mhcharlist, `,
mhstr =
random, mhrand, 6, 10
loop, %mhrand%
{       random, pick, 1, %chararray0%
        item := chararray%pick%
        mhstr = %mhstr%%item%
}
generatequestion: ;secret  question
qcharlist = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z, , , , , , , , , 
stringsplit, chararray, qcharlist, `,
qstr =
random, qrand, 8, 16
loop, %qrand%
{       random, pick, 1, %chararray0%
        item := chararray%pick%
        qstr = %qstr%%item%
}
generatepass: ;password
pcharlist = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0
stringsplit, chararray, pcharlist, `,
pstr =
random, prand, 10, 20
loop, %prand%
{       random, pick, 1, %chararray0%
        item := chararray%pick%
        pstr = %pstr%%item%
}
ahkname = %nstr%
ahkmail = %mstr%@%mhstr%.com
ahksecret = %qstr%
ahkpass = %pstr%
guicontrol,, ahkname, %mstr%
guicontrol,, ahkpass, %pstr%
hackcheck:
gui, submit, nohide

if ahktf2 = 0
{
guicontrol,, hacks, 0
guicontrol, disable, hacks
}
if ahktf2 = 1
{
guicontrol, enable, hacks
}
if hacks = yes
if ahktf2 = 0
guicontrol,, hacks, 0
return


buttoncancel:
exitapp
return ; you won't return from that

buttoncreate:
gui, submit, nohide
if ahkhack = 1
{
	ifnotexist, %hackpath%
	{
		msgbox, Hacks not found where you pointed to.
		exitapp
	}
	run, %hackpath%
	msgbox, You will need to manually activate your hacks.
}

if ahktf2 = 1
ahktf2 = -applaunch 440 
if ahktf2 = 0
ahktf2 = 

regexmatch(ahkipstring, "(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}):(\d{1,5})", ahkip)
if (ahkip == "")
{
guicontrol,, ahkipstring, no ip found!
connect = 
}

if not (ahkip == "")
{
guicontrol,, ahkipstring, will connect to %ahkip%...
connect = +connect %ahkip%
}
run, %steampath%\steam.exe
sleep, 1000
winwaitactive, Steam Login
sleep, 300
send, {tab}
sleep, 30
send, {tab}
sleep, 30
send, {tab}
sleep, 30
send, {tab}
sleep, 30
send, {enter}
sleep, 300
send, {enter}
sleep, 300
send, {enter}
sleep, 100
send, {enter}
sleep, 100
send, {enter}
sleep, 100
send, %ahkname%{tab}
sleep, 30
send, %ahkpass%{tab}
sleep, 30
send, %ahkpass%
sleep, 3010
send, {enter}
winwaitactive, Steam - working
winwaitclose, Steam - working
sleep, 30
send, %ahkmail%{tab}
sleep, 30
send, %ahkmail%
sleep, 30
send, {enter}
winwaitactive, Steam - working
winwaitclose, Steam - working
sleep, 30
send, {downarrow}
sleep, 30
send, {tab}
sleep, 30
send, %ahksecret%
sleep, 30
send, {enter}
winwaitactive, Steam - Working
winwaitclose, Steam - Working
sleep, 30
send, {enter}
sleep, 30
send, {enter}
if changename = 1
{
	sleep, 5000
	run, C:\Program Files\Internet Explorer\iexplore steam://settings/friends		
	sleep, 300	
	winactivate, Settings
	winwaitactive, Settings
	sleep, 300
	send, {tab}
	sleep, 30
	send, {home}
	sleep, 30
	send, {delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}{delete}
	sleep, 30
	send, %newname%
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {tab}
	sleep, 30
	send, {enter}
}
run, %steampath%/steam.exe %ahktf2% %launchoptions% %connect%
winclose, Steam
goto gui