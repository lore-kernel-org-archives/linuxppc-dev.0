Date: Fri, 11 Jul 2003 11:50:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030711185050.GB17433@ip68-0-152-218.tc.ph.cox.net>
References: <20030711155226.GV17433@ip68-0-152-218.tc.ph.cox.net> <20030711182921.0F0CFC6D82@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030711182921.0F0CFC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 11, 2003 at 08:29:16PM +0200, Wolfgang Denk wrote:
>
> Dear Tom,
>
> in message <20030711155226.GV17433@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > No, but I do wonder if you ever plan on sending anything out again.  It
>
> Has anything  significantly  changed?  Patches/extensions  are  still
> accepted for 2.5 only, right? Does this tree work for 8xx systems?

2.5 untested, so that when 2.6 rolls around there is less pain for all,
and 2.4 tested.  This hasn't changed, and is becoming a bit more of a
trend even outside of the PPC world.  It's not even that hard to test
now, doing 'make ARCH=ppc CROSS_COMPILE=foo arch/ppc/foo/bar.o' will
work and is a feature of the new build system.

>
> IIRC the last time we such discussions simply nothing  happened:  see
> for example to code for dp_alloc / dp_free that was submitted several
> times.

google knows nothing of this, can you give a pointer into the thread
please?  Thanks.

> Or see thread "set_rtc_time() cleanup / normalization" in May
> this year.

I just re-read most of it, and Gabriel Paubert, who wrote most / all of
that code, and is the 'maintainer' of sorts objected, a few solutions to
make everyone happy were proposed (ppc_md hook or similar, I believe)
and no further patch was submitted.

> If you suggest there is a way to get patches really included into the
> "official" trees, please let me know how to do this.

As always, send things in functional hunks.  If for example, the 8xx /
8260 enet and serial drivers (Of note: the 4xx enet driver now falls
into this catagory) in 2.6 get moved into drivers/serial (And rewritten)
and drivers/net (cleaned up?), rmk (serial maintainer) and Jeff Garzik
(net driver maintainer) aren't going to take a large patch without at
least as much griping as I've made in the past, if not more.  And when
someone comments on the reasoning, logic, or suggests an alternate way
of doing things for people which need the current behavior / whatever,
re-spin the patch.  All of the patches you've submitted to me like this,
AFAIK, have either been accepted, or I've told you I cannot take that
patch, it needs to be sent elsewhere.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
