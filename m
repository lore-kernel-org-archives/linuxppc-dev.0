To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_5 source tree (and others) 
In-Reply-To: Message from Cort Dougan <cort@fsmlabs.com>
   of "Thu, 10 May 2001 21:14:08 CST." <20010510211408.P1595@ftsoj.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 15:43:25 +1000
Message-ID: <23573.989559805@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 10 May 2001 21:14:08 -0600, Cort Dougan <cort@fsmlabs.com> writes:
>I'm not sure what the current plan is at BitMover but I believe that's a
>feature of BitKeeper/Pro but not BitKeeper/Open.

I don't know the exact situation either - all I can go on is their website,
which describes two versions of BitKeeper - BK/Pro and BK/Basic. The BK/Basic
page says it provides everything that BK/Pro does, except for:

        - Hierarchical repositories
        - Ability to resolve rename conflicts in anything other than
	  the master repository
        - Rollback
        - Global multi-site
        - Event triggers
        - LOD (line of development) support

There is also a description of BK/Web, which appears to be a third part.

Based on this, I am assuming that BK/Basic is (or will be) the free version,
and BK/Pro is (or will be) the commercial version that you must pay for.
It seems to me that it would be pointless to use BK/Basic only for the Linux
kernel - all this stuff, and LODs in particular, are too useful.

I have no problem with them selling software, and I quite like BitKeeper -
it feels right, like it has the correct approach to software version control
(at least in the case where there is a large number of distributed developers
and one single entity being developed consisting of a huge number of files -
exactly the case with the Linux source).

However, I would question the use of closed-source, non-free software to
develop open-source, free software - in effect, it makes the software being
developed (in this case Linux) closed and non-free - imagine, for example,
if you had the Linux source, but had to pay for a compiler to build it -
and not just any C compiler - you had to buy company X's compiler. Now I
know there are other methods available of getting the source besides BK
(rsync, ftp of tarballs, etc), but you don't get the version control info,
which I reckon is getting almost as essential as the compiler these days.

>Linux developers
>(possibly all open-source people) are able to get BitKeeper/Pro.

(I assume you mean for free - but obviously binary only; no source code)

This would be welcome - but how does one qualify as a "linux developer" or
an "open-source person"? If I can register for free with an independent
organisation and BitMover recognised this then great - but if it is left up
to BitMover to decide whether I qualify, this seems somewhat less than
satisfactory.

Sorry for rambling - this is really just an academic argument - the real
world rolls on... (we may even pay for BitKeeper :-) Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
