Message-ID: <3770AA21.8AB15E21@mpifr-bonn.mpg.de>
Date: Wed, 23 Jun 1999 11:34:25 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Again: 3-Button-Mice
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

	please excuse me if I bother again with an old issue---I have a PowerBook
G3/300 with a 3-button Countou Mouse (adb) attached to it, but I am not able to
get all three buttons running.  dmesg tells me

adb devices: [2]: 2 c4 [3]: 3 66 [7]: 7 1f [15]: 3 1
...
ADB mouse at 3, handler 1
ADB mouse at 15, handler set to 4 (trackpad)
ADB mouse at 3, handler 1
ADB mouse at 15, handler set to 4 (trackpad)
ADB keyboard at 2, handler 1
Macintosh ADB mouse driver installed.

I tried to alter the handler of device #3 using mousemode, but without success:

[root@pc128 /root]# /sbin/mousemode 3 4
handler for addr 3 was 102
trying to set handler to 4...
handler is now 102

I run the accelerated video driver for the atyfb device (from linux 2.3); might
this be connected with my problem?

Thanks for any help, Albrecht.


-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Abteilung f\"ur Infrarot-Interferometrie    |  \    /      |  /   |         |
| Auf dem H\"ugel 69                          |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
