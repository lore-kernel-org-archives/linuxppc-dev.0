Message-Id: <5.1.0.14.2.20030617001918.02f0df58@mail.ebshome.net>
Date: Tue, 17 Jun 2003 00:25:17 -0700
To: Marius Groeger <mag@sysgo.de>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: lowlat & preeempt
Cc: Robin Gilks <robin.gilks@tait.co.nz>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.56.0306170908310.18398@mag.devdep.sysgo.de>
References: <5.1.0.14.2.20030616234808.02ddad50@mail.ebshome.net>
 <3EEE93C5.4090302@tait.co.nz>
 <3EEE93C5.4090302@tait.co.nz>
 <5.1.0.14.2.20030616234808.02ddad50@mail.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:15 AM 6/17/2003, Marius Groeger wrote:
>On Mon, 16 Jun 2003, Eugene Surovegin wrote:
>
> > >The low latency patch is now part of the kpreempt patch. A kpreempt
> > >patch for 2.4.21-pre1 can be found here:
> > >
> > >http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/
> >
> > Are you sure?
> >
> > preempt-kernel-rml-2.4.21-pre1-1.patch doesn't have
> >   - low latency stuff (http://www.zip.com.au/~akpm/linux/schedlat.html)
> > or
> >   - lock-breaking stuff
> > (http://www.kernel.org/pub/linux/kernel/people/rml/lock-break/)
>
>Yes, of course, lock breaking is also needed. I always use both
>kpreempt and lock-break. Wrong assumption on my part.

OK :)

I also use preempt + lock-break.
Preempt patch alone is not good enough for our applications.

>Anyway, with this combination you don't need the low-latency patches
>anymore (according to www.tech9.net/rml/linux):

<snip>

He is probably right.

Although lock-break patch wasn't updated for some time.
Andrew Morton's low latency patch seems to be more up to date ...

I'm thinking about trying it instead of lock-break or maybe just full patch
set from (http://members.optusnet.com.au/ckolivas/kernel/). It probably
will require some PPC mods though...

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
