Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdog.com
Subject: some questions on new dual 1Gig G4's support?
Date: Sat, 2 Feb 2002 09:50:28 -0500
MIME-Version: 1.0
Message-Id: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have never played around in the cpu specific parts of the kernel (except
for cache flush code) and don't really know my way around (yet!).

I have collected the 7455 info (pdf files including errata) from the
Motorola site and rsynced benh latest 2.4 kernel.

I grepped for 7450 and found references to it in the following files:

in arch/ppc/kernel/
in l2cr.S, sleep.S, cputable.c, and idle.c

Ben Hinted that simply duplicating the cputable.c entry for the 7450 to
make a 7455 might be a good beginning.

So this now leads me to a few questions:

1. are the cpu specific things I might have to play with all in the files
I found that reference 7450 or are there other files I need to play with

2. I read the errata for the 7455 and it was quite short.  Are errata
cumulative  in some way?  Are these just the new errata since the 7450?
(i.e. do I need to grab and worry about the 7450 errata too?).  Or has the
errata listed in the 7450 been dealt with by changes in the 7455 and this
is all I need to know hardware errata-wise.

3. Are there any other references I should be reading that describe
differences in the 7450 and the 7455 that are important for getting a
kernel up on my new machine?

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
