Message-ID: <376E5609.C5949344@mpifr-bonn.mpg.de>
Date: Mon, 21 Jun 1999 17:11:05 +0200
From: Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
CC: LinuxPPC Users <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Accel. Video on PB G3/300?
References: <Pine.LNX.4.10.9906211620010.30202-100000@michelin.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 
> On Mon, 21 Jun 1999, Albrecht Dreß wrote:
> >       I managed to install R5 on a PowerBook G3/300, but I could not get accelerated
> > video running. I used "video=atyfb:vmode:14,cmode:32,mclk:xx" with xx from 63 to
> > 73, but got always the "garbage screen". Has anyone had better results?
> 
> Which kernel version is shipped with R5? Does the kernel tell you the estimated
> clock crystal frequency (XTAL) during the initialization of the ATI frame
> buffer device (atyfb)? If not, they're using a kernel without the clock crystal
> frequency estimation patch (present in 2.3.6).

The kernel version is 2.2.6. If I start with the "No video driver" option
checked (from BootX), the startup messages siplly tell me that

MacOS display is /pci/ATY,RageLTPro
Using unsupported 1024x768 ATY,RageLTPro at 82801000, depth=32, pitch=4096
Console: switching to colour frame buffer device 128x48
fb0: Open Firmware frame buffer device on /pci/ATY,RageLTPro

Unfortunately, I can not telnet yet to the PB, so I can't see the startup
messages when I use the atyfb option...

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
