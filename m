Message-ID: <38FAB0DC.9704B50@pop.agri.ch>
Date: Mon, 17 Apr 2000 08:36:12 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: a.tobler@schweiz.ch
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Anyone running LinuxPPC2000+PCMCIA+WallStreet?
References: <Pine.LNX.3.96.1000416220038.20340A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
"Mark S. Mathews" wrote:
>
> Hi Folks,
>
> We're trying to run a LinuxPPC 2000 install on a WallStreet M4753 and
> trying to get PCMCIA going.  Of course, we've had loads of trouble.  ;-)
>
> We've been trying with the pmac-2.2.15pre7 kernel and a variety of pcmcia
> versions.  No matter what, we always get panics when inserting a card.
>
> At this point we're pretty sure the problem is in i82365 or cardmgr, not a
> specific card driver.  We're not getting far enough to deal w/ a
> specific driver.  We've tried a couple of network cards, including
> some that aren't supported by pcmcia-cs at all (we were hoping for
> 'successful' failure).
>
> Any recommendations?  We'll send .configs and such if anyone wants to see
> them.

what pcmcia-cs pkg are you running? The latest is now 3.1.14.
Port and memory range in config.opts?
Comment all memory ranges out except the 0x90000000-0x90ffffff.
In the port range you have to play/figure out what's the best one for
you.
Some simple cards are happy with 0x0-0xfff, others need a higher range.
E.g. 0x400-0x4ff or 0x1000-0x10ff
or 0x100-0x1ff.
Are you running PCMCIA or CardBus cards?
Are modems involved?

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
