Message-ID: <3C0D7C54.A28FA732@mvista.com>
Date: Tue, 04 Dec 2001 18:45:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: mod+linuxppc-dev@missioncriticallinux.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc support for Galileo GT64260
References: <200112042332.SAA17067@missioncriticallinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


mod+linuxppc-dev@missioncriticallinux.com wrote:

> I'm asking because I recall seeing
> messages on these lists saying that
> code had been checked in with interrupt
> problems, PCI problems, no integrated-Enet
> driver and generally in "needs work"
> condition.  I notice that there is now a
> (strangely familiar) driver included for
> the integrated Enet,

Yes, its the same driver the galileo originally wrote that mclx, your
company, moved to 2.4 AFAICT.  If you wrote it, fine, change the
copyright and author.  BTW, its *still* needs work so feel free.


> but (except for the
> recent exchange about how the GT64260 and
> VT82C686B don't play so nice together) I
> don't find much 64260-related discussion
> here except one terse followup message
> stating that PCI works.

There have been a few pushes to 64260 related code since the original
push.  If you want to keep up on it, do regular pulls and look at the
code and/or get on the linuxppc-commit mailing list and look for pushes
that touch files you care about.

> So, is anybody using the current code?

Yes, me--at least the code of a week or so ago.  Others are to if they
wish to speak up.

> Would I be wrong to interpret the fact
> that it wouldn't compile when I tried it
> today as indication that not much has

> happened since the initial checkin by
> MontaVista?

My src tree is a week or so out of date but it compiles just fine.
Not compiling is news to me.  Why don't you fix it and send a patch? ;)

> Are the interrupt problems
> alluded to at the time of that initial
> checkin (could somebody characterize
> them for me?) still an issue?

You can still lose PCI interrupts with the 64260 (see errata) which is a
real problem if you have an nfs-mounted root filesystem.  The 64260A is
stable for me except after a while something happens and my bdi can no
longer talk to the processor and the system appears to hang.

>  Does
> the PCI support seem solid?

It was last time I tested.

> Anything
> in particular I need to watch out for?

No mpsc/uart driver yet.  That's being worked on but if you have one that
works well with the 64260A's errata, feel free to pass it along.  I know
there is at least one person working on a dual 7450 + 64260A combo.
Don't think its up with both cpu's yet.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
