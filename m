Mime-Version: 1.0
Message-Id: <v04220801b5ac55fa19ba@[10.0.0.42]>
In-Reply-To: <200007311221.NAA04559@hyperion.valhalla.net>
References: <200007311221.NAA04559@hyperion.valhalla.net>
Date: Tue, 1 Aug 2000 03:28:00 -0700
To: "Iain Sandoe" <iain@sandoe.co.uk>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Stealth port problems
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:22 PM +0100 7/31/00, Iain Sandoe wrote:
>On  Mon, Jul 31, 2000, I wrote...
>>  On  Mon, Jul 31, 2000, Timothy A. Seufert wrote:
>>>  At 10:11 AM +0100 7/31/00, Iain Sandoe wrote:
>>>
>>>>BTW st SCC-XXdma stuff *is* enabled on my G3 by default.
>>>
>>>  Beige or blue?  On my B&W G3 it's not enabled, I only see the plain
>>>  non-DMA RX and TX interrupts.
>>
>>  Beige - but I was burbling (again) - I build all my own kernels... so YMMV
>
>FWIW:
>With the same kernel...
>On my Lombard - the SCC XXdma does *not* show
>On my 9600 - it does.

So it looks like it's not getting enabled on New World machines.
After a brief look at the driver init code my impression (quite
possibly a wildly inaccurate one BTW) is that the driver wants DMA
channels and/or IRQs already partially configured.  On New World
machines booted via yaboot these may not be configured by OF.  On Old
World machines booted via BootX MacOS does the initialization.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
