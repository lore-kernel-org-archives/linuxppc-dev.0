Message-Id: <200007301643.RAA16451@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 17:44:03 +0100
Subject: Re: Stealth port problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Sun, Jul 30, 2000, Takashi Oe wrote:
> On Sun, 30 Jul 2000, Iain Sandoe wrote:
>
>> > Ok, this is a news to me.  I'm certain that SCC on oldworld pmacs is
>> > 85C30.  When did the change to 85230 occur?  If I remember correctly,
>> > some DMA setup codes in macserial.c need to know about it if it's dealing
>> > with 85230 rather than 85C30.
>>
>> OK - I don't know for certain - but the code refers to an "ESCC" which is
>> the name of the 85230 - the 8530 should just be called "SCC".
>
> It's not 8530.  I got an impression from Zilog's manual that ESCC refers
> to both 85230 and 85C30 loosely.

That manual has "Iain's all-time-award-for-the-worst-written-chip-manual"
:-(

>  Actually, on some pages, the term was
> used to refer to functionalities only available on 85230, and, on other
> pages, it was used to describe something 8530 doesn't support but both
> 85C30 and 85230 do.  AMD's usage of the term ESCC is yet slightly
> different, IIRC.
>
> Anyway, Apple's documentation uses the term ESCC and 85C30
> interchangeably, and I think the driver's usage of the term "ESCC" comes
> from there.

OK.  Well, that makes things worse - rather than better (re. the original
problem - if DMA is not enabled).  The 8530 had only 4 bytes of RX buffer &
only 2 Tx (the ESCC doubled these) - can't remember about the 85C30.  Wrote
drivers for the other two some years ago on a different OS (so memory might
be a shade foggy).

Of course, Apple has implemented the devices as a cell in an ASIC - so who
knows?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
