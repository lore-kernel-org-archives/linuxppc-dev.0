To: "'linuxppc-embedded@lists.linuxppc.org'"
    <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3A71B316.91C9EDBD@lucent.com>
Date: Fri, 26 Jan 2001 11:25:42 -0600
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
Subject: Re: Query: PCI and Ethernet hardware/drivers
References: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com> <3A718D21.66F9227D@lucent.com> <3A71946D.C98063EB@agelectronics.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian Cox wrote:
> Tom Roberts wrote:
> > 1) Does Linux/PPC handle the PCI bus properly?
> Short answer, yes. Long answer, how strange a PCI system do you want to
> build?

Nothing obscure, I hope. We need a local PCI bus to interface to
two ethernet MACs, some HDLC interfaces, and the H.110 telephony bus
(Lucent has a part which directly interfaces H.110 to PCI). While these
other devices will be PCI masters (for DMA), they are all quite dumb
and will be programmed from our 7410s (Linux).


> Does this mean that your board is intended to be a PCI agent?

I don't think so. There will be no other CPUs on the PCI bus, just
peripherals. But we want them to DMA into our big memory.


> > 4) We favor a 4-CPU SMP configuration. What not-so-obvious problems
> >    are we likely to face?
> Designing a good interrupt controller.

We have done this for our current boards, but they have no PCI bus,
only local peripherals directly connected to a 60x or MAX bus. "good"
to us merely means it works reliably; we have only rather low data
rates as this is primarily a compute engine -- 200 kilobytes/sec
would be a high data rate to us (during boot it will be higher).

Thank you very much for your quick response.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
