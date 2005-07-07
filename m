Return-Path: <mcnernbm@notes.udayton.edu>
Received: from student03.udayton.edu (student03.udayton.edu [131.238.75.43])
	by ozlabs.org (Postfix) with ESMTP id AE3BB67BC3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 03:01:35 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFEB66331D.10CE4400-ON85257037.005D805A-85257037.005D85D7@notes.udayton.edu>
From: mcnernbm@notes.udayton.edu
Date: Thu, 7 Jul 2005 13:01:33 -0400
Content-Type: multipart/mixed; boundary="=_mixed 005D85D485257037_="
Subject: Fw: Montavista Patch for ml403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=_mixed 005D85D485257037_=
Content-Type: multipart/alternative;
	boundary="=_alternative 005D85D485257037_="


--=_alternative 005D85D485257037_=
Content-Type: text/plain; charset="US-ASCII"

Contained with in the reference design for the xilinx ml403 board is a 
patch for the montavista ml403 preview kit ot allow one to build the 
kernel for the ml403 board.  But I am having trouble applying the patch. 
Does anyone know how to properly apply this patch.  Also I tried to follow 
the instrucions on coping the bsp files over but exactly where to place 
them.  Do I over write the folders with in the arch directory and the 
drivers folder in the main kernel directory?  Its not 100% clear what 
files I need to over write.
Any help would be greatly appreciated.
Attached is the patch that come with the xilinx ml403 reference design

Brett

--=_alternative 005D85D485257037_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Contained with in the reference design
for the xilinx ml403 board is a patch for the montavista ml403 preview
kit ot allow one to build the kernel for the ml403 board. &nbsp;But I am
having trouble applying the patch. &nbsp;Does anyone know how to properly
apply this patch. &nbsp;Also I tried to follow the instrucions on coping
the bsp files over but exactly where to place them. &nbsp;Do I over write
the folders with in the arch directory and the drivers folder in the main
kernel directory? &nbsp;Its not 100% clear what files I need to over write.</font>
<br><font size=2 face="sans-serif">Any help would be greatly appreciated.</font>
<br><font size=2 face="sans-serif">Attached is the patch that come with
the xilinx ml403 reference design</font>
<br>
<br><font size=2 face="sans-serif">Brett</font>
<br>
--=_alternative 005D85D485257037_=--

--=_mixed 005D85D485257037_=
Content-Type: application/octet-stream; name="patch_linux"
Content-Disposition: attachment; filename="patch_linux"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgppZiBbICQjICE9IDEgXSA7IHRoZW4KICBlY2hvICJVc2FnZTogJDAgPFBhdGgg
dG8gTW9udGFWaXN0YSBMaW51eCAzLjEgS2VybmVsIGZvciB0aGUgTUwzMDAgYm9hcmQ+IgogIGVj
aG8KICBlY2hvICIkMCBwYXRjaGVzIGEgTW9udGFWaXN0YSBMaW51eCAzLjEga2VybmVsIGZvciB0
aGUiCiAgZWNobyAiTUwzMDAgYm9hcmQgKE1MMzAwIExTUCkgdG8gbWFrZSBpdCB1c2VhYmxlIHdp
dGggdGhlIE1MNDAzIGJvYXJkLiIKICBlY2hvICJSdW4gdGhpcyBzY3JpcHQgQUZURVIgeW91IGhh
dmUgZ2VuZXJhdGVkIHRoZSBMaW51eCBib2FyZCBzdXBwb3J0IHBhY2thZ2UiCiAgZWNobyAid2l0
aCBYUFMuIFByb3ZpZGUgdGhlIHBhdGggdG8gYSBDT1BZIG9mIHRoZSBNb250YVZpc3RhIExpbnV4
IDMuMSBrZXJuZWwiCiAgZWNobyAiYXMgYSBwYXJhbWV0ZXIgdG8gJDAuIgogIGV4aXQgMQpmaQoK
IyBDaGVjayB0aGF0IHRoZSByZXF1aXJlZCB0b29scyBhbmQgZmlsZXMgYXJlIGFjY2Vzc2libGUK
dW56aXA9YHdoaWNoIHVuemlwIDI+IC9kZXYvbnVsbGAKWyAhIC14ICIkdW56aXAiIF0gJiYgZWNo
byAiQWJvcnQuIENhbm5vdCBmaW5kIHVuemlwIGluIHRoZSBzZWFyY2ggcGF0aC4iICYmIGV4aXQg
MQoKcGF0Y2g9YHdoaWNoIHBhdGNoIDI+IC9kZXYvbnVsbGAKWyAhIC14ICIkcGF0Y2giIF0gJiYg
ZWNobyAiQWJvcnQuIENhbm5vdCBmaW5kIHBhdGNoIGluIHRoZSBzZWFyY2ggcGF0aC4iICYmIGV4
aXQgMQoKWyAhIC1yIG1sNDAzLmRpZmYuemlwIF0gJiYgZWNobyAiQWJvcnQuIENhbm5vdCByZWFk
IG1sNDAzLmRpZmYuemlwLiIgJiYgZXhpdCAxCgpbICEgLXIgLmNvbmZpZyBdICYmIGVjaG8gIkFi
b3J0LiBDYW5ub3QgcmVhZCAuY29uZmlnLiIgJiYgZXhpdCAxCgpic3BwPS4uL3BwYzQwNV8wL2xp
YnNyYy9saW51eF9tdmwzMV92MV8wMF9hL2xpbnV4ClsgISAtciAiJGJzcHAiIF0gJiYgZWNobyAi
QWJvcnQuIENhbm5vdCByZWFkICRic3BwLiBEaWQgeW91IGNyZWF0ZSB0aGUgTGludXggQlNQPyIg
JiYgZXhpdCAxCgp4cD1hcmNoL3BwYy9wbGF0Zm9ybXMveGlsaW54X29jcC94cGFyYW1ldGVyc19t
bDMwMC5oClsgISAtciAiJGJzcHAvJHhwIiBdICYmIGVjaG8gIkFib3J0LiBDYW5ub3QgcmVhZCAk
YnNwcC8keHAuIERpZCB5b3UgY3JlYXRlIHRoZSBMaW51eCBCU1A/IiAmJiBleGl0IDEKCmxwPSQx
ClsgISAtdyAiJGxwIiBdICYmIGVjaG8gIkFib3J0LiBDYW5ub3QgcGF0Y2ggaW4gJGxwLiIgJiYg
ZXhpdCAxCgojIE9rLCBkbyBpdC4KY3AgLmNvbmZpZyAkbHAKY3AgLVJwICRic3BwLyogJGxwCiR1
bnppcCAtcCBtbDQwMy5kaWZmLnppcCB8ICRwYXRjaCAtZCAkbHAgLXAwIC1GMApjYXQgPj4gJGxw
LyR4cCA8PEVPRgojZGVmaW5lIFhQQVJfT1BCX0xDRF9JTlRFUkZBQ0VfMF9CQVNFQUREUiBYUEFS
X09QQl9HUElPX0NIQVJfTENEXzBfQkFTRUFERFIKI2RlZmluZSBYUEFSX09QQl9MQ0RfSU5URVJG
QUNFXzBfSElHSEFERFIgWFBBUl9PUEJfR1BJT19DSEFSX0xDRF8wX0hJR0hBRERSCkVPRgo=

--=_mixed 005D85D485257037_=--
