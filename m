Message-Id: <199907312248.QAA05182@carboncode.com>
To: roikawa@rr.iij4u.or.jp, linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
Date: Sat, 31 Jul 1999 18:56:20 -0700
From: Don Lunder <speedy@carboncode.com>
In-Reply-To: <19990801005311S.roikawa@rr.iij4u.or.jp>
References: <19990801005311S.roikawa@rr.iij4u.or.jp>
Content-Type: text/plain; charset="US-ASCII"
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I got to try out this X server, and it seems to work quite well.  Here is 
the output on starting it:

Xpmac / X Window System (X11R6.3)
Release Date: July 31, 1999

Running in mode=10, depth=16; req mode=0 depth=0
Using VT number 7
Mapped frame buffer (physaddr 0x81800000 size 0xea610) at 0x30057000.
C&T 6555x detected. Mapping MMIO/IO regsiter...
Mapped physaddr 0x81400000 size 0x20000 at 0x30014000.
Mapped physaddr 0xf2000000 size 0x1000 at 0x30034000.
C&T 6555x successfully mapped. Starting acceleration...


Running WindowMaker-0.60.0-4, on a PowerBook 2400/180

The only thing I saw out of the ordinary, were the verticle bars that would 
appear when moving windows fast.  (Altho moving the xmms (mp3 player) 
window didn't seem to leave any artifacts)  Also, if I drug windows between 
desktops, verticle bars or other artifacts would appear in the window being 
moved.  Usually Yellow or Blue it seems (this could just be for me tho)

I booted in Linux with it running a video driver (not the OF based one), 
does this make a diffrence, would you like to know of any other setups?

On a side note, I noticed that when I run with the video driver on the 
2400, the first time I start X, instead of a "grey" pixely screen, it has a 
blue hue to it, and it will seg fault, but if I try running it again, it 
starts up correctly, and goes into WindowMaker.

On my machine, I was able to exit WindowMaker just fine with out any 
errors, or hard reboots.

I'll keep playing with it, and tell you what I find, if you have any 
specific requests, please do ask!

Thanks for your hard work, time and effort!!!!

Don Lunder

PS After Spell checking the email, I see that register has a typo in the 
Xpmac out put. <shrug>


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
