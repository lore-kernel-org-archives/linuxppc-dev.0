Message-Id: <l03130308b39f11c8f40e@[209.226.106.187]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 29 Jun 1999 20:44:14 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Eric Dorland <dorland@lords.com>
Subject: Problems with the atyfb driver on Power Mac G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I posted this message (see below) to the user list, but didn't get much of
a response. Because it's more a bug in the atyfb driver I thought you guys
would have more luck. My apologies if you've seen this message already.


>From reading the list recently, it seems a lot of Powerbook G3 are having
problems with the atyfb driver. I'm also having problems, but with my Power
Mac G3 266 rev. 2 using its onboard Rage Pro card and 2 MB of VRAM. When I
boot up with the kernel argument video=atyfb:vmode:13,cmode:16 I get
"dancing pixels", or snow if you prefer, down one side of the screen as
illustarted by this rather crude drawing:

-------------------------
| .			|
| .			|
| .			|
| .			|
| .			|	The dots are the dancing pixels, which
| .			|	flicker on and off.
| .			|
| .			|
| .			|
-------------------------

These pixels flicker on and off down the left side the screen in an
extremely irritating fashion in the console and X. When I boot up using the
above arguments using the 2.3.6 kernel I get a line stating:

atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 2M SGRAM, 14.31818 MHz
XTAL, 230 MHz PLL, 100 Mhz MCLK

Through playing with the mclk and pll arguments (mclk:68,pll:200) I can
reduce the amount of "pixel dancing", but when there is a lot of movement
on the screen it is still quite noticable. I got these values from sheer
experimenting, and could be slowing cooking my chip for all I know.

Has anyone with a Power Mac (especially with a similar set up) exprienced
similar problems? Any solutions? BTW the atyfb driver in the 2.1.130 kernel
worked very well, these problems started when I began using the 2.2.x
kernels. Anyone know what might have changed between the two or have a copy
of atyfb.c from the 2.1.130 kernel (Geert maybe :).

PS: I realise I could use "No video driver" and use Xpmac and force mach64
acceleration, but I would much rather use XF68_FBDEV so I can change
resolutions from linux and such. Also, I'm stubborn.

Eric Dorland
mailto:dorland@lords.com



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
