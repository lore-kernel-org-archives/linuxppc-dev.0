Message-Id: <200007301300.OAA07050@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 14:01:19 +0100
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
> [...]
>> The RX buffer in an 85230 (which is actually the chip - IIRC - an enhanced
>> 8530) is 8 characters deep
>
> Ok, this is a news to me.  I'm certain that SCC on oldworld pmacs is
> 85C30.  When did the change to 85230 occur?  If I remember correctly,
> some DMA setup codes in macserial.c need to know about it if it's dealing
> with 85230 rather than 85C30.

OK - I don't know for certain - but the code refers to an "ESCC" which is
the name of the 85230 - the 8530 should just be called "SCC".


>>                            - so any more that about 700 us IRQ block will
>> cause a drop out at 115200 continuous...
>
> With DMA, this is a non-issue as far as serial driver is concerned.

This is, of course, true - unless something blocks for long enough to
prevent the IRQ that indicates end-of-dma transfer (assuming there is one).

Iain,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
