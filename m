Date: Fri, 16 Jul 2004 18:23:10 +1000
From: Rob Weir <rweir@ertius.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk oops(?) on g4 ibook
Message-ID: <20040716082310.GB4608@ooder.ertius.org>
References: <20040701041703.GH27929@ooder.ertius.org> <20040716074152.GC3698@bogon.ms20.nix>
Mime-Version: 1.0
In-Reply-To: <20040716074152.GC3698@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 16, 2004 at 09:41:52AM +0200, Guido Guenther said
> On Thu, Jul 01, 2004 at 02:17:03PM +1000, Rob Weir wrote:
> > I've been using Guido's pmdisk patch with...a fair amount
> > of success, but it occasionally oopses on resume (even with
> > USB/dmasound/therm_adt746x modules unloaded), and fairly often takes
>
> Hmm...I've never seen this. I'll have a look.

Everytime I've resumed in the past week I've got an oops, then a series
of "out of memory" errors while things like hotplug restart...would it
be useful I wrote this oops down by hand?

> > a looooooooong time to suspend (more then 3 minutes), sitting at the
>
> I think this is a general problem of pmdisk, not powerpc specific, not
> nice though.

Hm, but *sometimes* (soon after I installed it, mostly) it suspends very
quickly.

--
Words of the day:     Mantis UK Hacker encryption New World Order eavesdropping

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
