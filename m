Message-Id: <200008011111.MAA03285@hyperion.valhalla.net>
Date: Tue, 01 Aug 2000 12:11:56 +0100
Subject: Re: Stealth port problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Tue, Aug 1, 2000,Timothy A. Seufert wrote:
> At 1:22 PM +0100 7/31/00, Iain Sandoe wrote:
>>On  Mon, Jul 31, 2000, I wrote...
>>>  On  Mon, Jul 31, 2000, Timothy A. Seufert wrote:
>>>>  At 10:11 AM +0100 7/31/00, Iain Sandoe wrote:
>>>>
>>>>>BTW st SCC-XXdma stuff *is* enabled on my G3 by default.
>>>>
>>>>  Beige or blue?  On my B&W G3 it's not enabled, I only see the plain
>>>>  non-DMA RX and TX interrupts.
>>>
>>>  Beige - but I was burbling (again) - I build all my own kernels... so YMMV
>>
>>FWIW:
>>With the same kernel...
>>On my Lombard - the SCC XXdma does *not* show
>>On my 9600 - it does.
>
> So it looks like it's not getting enabled on New World machines.
> After a brief look at the driver init code my impression (quite
> possibly a wildly inaccurate one BTW) is that the driver wants DMA
> channels and/or IRQs already partially configured.  On New World
> machines booted via yaboot these may not be configured by OF.  On Old
> World machines booted via BootX MacOS does the initialization.

I think I saw a patch for this fly by yesterday :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
