Message-ID: <376F2C8C.542E544C@mpifr-bonn.mpg.de>
Date: Tue, 22 Jun 1999 08:26:21 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
CC: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Accel. Video on PB G3/300?
References: <Pine.LNX.4.10.9906211716100.30202-100000@michelin.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
[snip]
> Hence you need the clock crystal frequency estimation patch to be able to use
> atyfb and acceleration.

In the meantime, I got telnet running (was missing in inetd.conf), and booted
with the atyfb option, mclk set to 63. Now dmesg tells me upon boot:

MacOS display is /pci/ATY,RageLTPro
atyfb: 3D RAGE LT PRO [0x4c50 rev 0xdc] 4M SGRAM, 230 MHz PLL, 63 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on /pci/ATY,RageLTPro

> 
> Copying drivers/video/atyfb.c from 2.3.6 should do the trick.

I will try it...

Thanks, Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\ss                                     ----           |
| Max-Planck-Institut f\"ur Radioastronomie   |\       /      /o  o\          |
| Technische Abt. Optische Interferometrie    |  \    /      |  /   |         |
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
