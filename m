Subject: Re: kernel panic in slab.c
From: Hubert Figuiere <hub-linux-ppc@trantor.staff.proxad.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1064497450.702.12.camel@gaston>
References: <1064493093.17039.44.camel@trantor.staff.proxad.net>
	 <1064497450.702.12.camel@gaston>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1064499264.17038.70.camel@trantor.staff.proxad.net>
Mime-Version: 1.0
Date: Thu, 25 Sep 2003 16:14:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 2003-09-25 at 15:44, Benjamin Herrenschmidt wrote:

> Nice to see you using Linux again :)

I never stopped :-)

>
> What machine is this ?

Custom network hardware with a PrPMC750 Motorola board as MPU. We have a
few tiny patches for our custom devices, but nothing important here
IMHO.


> The bug shows that the poison checker found that a freed block got
> overriden. It didn't display more infos about the kind of pattern
> it found and/or a backtrace ? That would be helpful.

I might investigate.

> I've been trying to track down such kind of memory corruption for
> some time now, so if you have a good handle on it, I'm interested,
> as I suspect something wrong is going on in recent 2.4s

Fine, then I feel like investigating it since memory corruption are
probably the worst bugs. I don't have a good handle on the problem. I
often crash while running either "bird" or "swapper" (uptime don't
exceed 5 or 10 minutes). Even worse, sometime it crashes during boot up.
The only thing I'm sure is that it is fully reproducible as it plagged
me for quite sometime. I first thaught that hardware was at fault (like
defective MPU), but my co-workers don't have the problem, and in fact
disabled debugging.


Thanks

Hub
--
Hubert Figuière - Freebox SA. - +33 1 73 50 2 563
AIM/Yahoo!: hfiguiere, ICQ: 307453487

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
