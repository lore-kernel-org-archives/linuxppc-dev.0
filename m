Message-ID: <37809EF1.45C3C3F5@mpifr-bonn.mpg.de>
Date: Mon, 05 Jul 1999 14:02:57 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
Reply-To: ad@MPIfR-Bonn.MPG.de
MIME-Version: 1.0
To: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Countour (3 button) mouse
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

	I use LinuxPPC R5 on a PowerBook G3 with a Contour 3-button mouse. 
Unfortunately it is not recognised as a three-button-device, the middle and
right button both give a ButtonPress event for button 1 upon the first and a
ButtonRelease event upon the second click.  `mousemode 3 4' doesn't work; the
handler remains set to 102.

I know that this mouse does in fact work with all three buttons, because it did
out of the box with MkLinux DR3-something.

Can anybody help me to resolve this issue?

Thanks, Albrecht.

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
