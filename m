Message-ID: <39034610.7556461F@embeddededge.com>
Date: Sun, 23 Apr 2000 14:50:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brad Parker <brad@parker.boston.ma.us>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
References: <200004231142.HAA65437@p2.parker.boston.ma.us>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brad Parker wrote:

> Is CONFIG_ALL_PPC really "all ppc" or is it really "all macintosh platforms"?

It is really used to build a kernel that you want to boot on "all
PPC platforms."  I don't build any of the embedded systems with this,
althought I suppose (if you _really_ wanted this :-) you could get
the same binary to boot on the 8xx as the G4....It's not on my list
of things to do.

> I can put a #ifndef CONFIG_ALL_PPC around the feature_init call but I
> thought I'd ask the larger question... (and risk a tomato ;_)

Something is messed up.  I am currently editing -pre6, and there isn't
a call to feature_init from setup_arch like there used to be......
In fact, I can't find a call to it at all right now.  I am in the middle
of a ton of 8260 edits, so maybe it changed over the past day or so.

If you must, make the #ifdef in the file match the Makefile.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
