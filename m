Message-ID: <20000514083948.2998.qmail@www0x.netaddress.usa.net>
Date: 14 May 00 03:39:48 CDT
From: jeramy b smith <ultrapenguin@netscape.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Lombard hard freeze during long compile with mem>64
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One of the people having the problem said they could reproduce the hardlock if
they recompiled gnomehack several times. Here is some data I have collected.

Using the vanilla linuxppc 2k kernel I have been doing some lengthy compiles
(kde 1.9). One of my package builds went 2.5 hours. I have seen no problems
and I have been running the entire time without a reboot. I have compiled all
of kde 1.9 and I had to rebuild one of the lengthier packages 3 times.

I did try to compile gnomehack and it was fun to play afterwards although it
segfaulted after about 15 minutes.

By the way, I did all of my building with full helix gnome running, several
rxvts open, netscape running, and while talking in #mklinux with xchat. I also
ran gaim for a while during this period.

I am using a vanilla 2k install with a May build of Franz Sirl's gcc. My
lombard is a 300 or 333 with 192 megs of ram.


I am starting to doubt that this is a kernel level issue and I am starting to
look at more likly culprits. Perhaps overheating or some other odd problem.
Perhaps cheap memory modules.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
