Message-ID: <398AF755.E10D0C56@student.ethz.ch>
Date: Fri, 04 Aug 2000 19:03:17 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
References: <Pine.LNX.4.21.0008031541210.6020-100000@idd-01.imbc.gr> <398ADB57.9ABEDC6F@student.ethz.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

> 16 bit doesn't work neither with fbdev (colors completely off - does
> aty128fb still use 15 bit in fact?)

fbset -i reveals that it does.


Is anyone actively maintaining aty128fb or should I try to fix that as well as
the panning? Looking at the X r128 driver, it shouldn't be too hard.


Michel


--
Coming to you live from a finite point in the space-time continuum!
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
