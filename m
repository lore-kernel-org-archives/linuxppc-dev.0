Message-ID: <3A7551C2.22CEA0E8@agelectronics.co.uk>
Date: Mon, 29 Jan 2001 11:19:30 +0000
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Query: PCI and Ethernet hardware/drivers
References: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com> <3A718D21.66F9227D@lucent.com> <3A71946D.C98063EB@agelectronics.co.uk> <3A71B316.91C9EDBD@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Roberts wrote:

> Nothing obscure, I hope. We need a local PCI bus to interface to
> two ethernet MACs, some HDLC interfaces, and the H.110 telephony bus
> (Lucent has a part which directly interfaces H.110 to PCI). While these
> other devices will be PCI masters (for DMA), they are all quite dumb
> and will be programmed from our 7410s (Linux).

Sounds totally uncontroversial.

> > > 4) We favor a 4-CPU SMP configuration. What not-so-obvious problems
> > >    are we likely to face?
> > Designing a good interrupt controller.
>
> We have done this for our current boards, but they have no PCI bus,
> only local peripherals directly connected to a 60x or MAX bus. "good"
> to us merely means it works reliably; we have only rather low data
> rates as this is primarily a compute engine -- 200 kilobytes/sec
> would be a high data rate to us (during boot it will be higher).

You may have a low enough and predictable enough interrupt rate that you
can take some short cuts instead of a complete SMP OpenPIC
implementation. The more general problem of delivering an interrupt to
the "best" available CPU is an interesting exercise.

- Adrian Cox

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
