Date: Tue, 21 Nov 2000 08:36:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: whacked out 2.2.18preX - last gasp
Message-ID: <20001121083623.H552@opus.bloom.county>
References: <p04330100b63f9bce42dd@[192.168.0.1]> <20001121081013.G552@opus.bloom.county> <p04330103b64042f6fa28@[206.6.156.5]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p04330103b64042f6fa28@[206.6.156.5]>; from jeglin@4pi.com on Tue, Nov 21, 2000 at 10:25:45AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 21, 2000 at 10:25:45AM -0500, Stefan Jeglinski wrote:

> >  > It's frankly hard at this point to buy that one of my PCI devices is
> >>  walking over the kernel. Or if it is, it looks like the end of the
> >>  Linux line for my PowerTowerPro with the 2940 card. I think this is
> >>  either a bug in the aic7xxx driver that has been exposed by 2.2.18
> >>  changes (highly doubtful, there are too many 2940s out there for it
> >>  to have been missed), or a linux-pmac bug. I just don't know enough
> >>  yet to prove it, much less find it.
> >
> >Hmm.  2.2.18pre21 from linuxppc_2_2 bk works on my G4/Yikes! with a 2940UW
> >in it.  What compiler are you using?
>
> dmesg:
>
> 	gcc version 2.95.2 19991024 (release/franzo) #1
>
> rpm -qa |grep gcc:
>
> 	gcc-2.95.2-1i
> 	gcc-c++-2.95.2-1i
> 	gcc-objc-2.95.2-1i

You might wanna try 2.95.3-2j, which should be in fsirl's dir on dev.  But I
really do doubt this is why.

> What I'm worried about mainly is the 6 slots and the PCI bridge
> structure in the PowerTowerPro (akin to PowerMac 9500). It is more
> "complex" than G4, no? From my previous discussion with you and
> others, I gather that there are a lot of problems with the PCI stuff,
> that may not be cleared up for quite a while?

Actually, the linuxppc_2_5 bitkeeper tree (which is getting merged into
2_3, for inclusing into hopefully 2.4.0-final from linus) has a giant PCI
re-write, so 9500s/et al might actually work happily now.  But yes, from what
I've gathered from trying to work w/ a 9500 and 2.2.18pre21 there just might
be something broken now.  (The video card refuses to work at all, regardless
of slot).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
