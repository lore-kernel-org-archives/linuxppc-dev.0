Message-Id: <200007251835.TAA17680@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 19:29:51 +0100
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev@lists.linuxppc.org, jsun@mvista.com
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 25, 2000, Geert Uytterhoeven wrote:
> On Mon, 24 Jul 2000, Iain Sandoe wrote:
[...]
>> I still haven't found the "hard-block" that is effecting the overall audio
>> latency performance... ah well, back to the drawing board...
>
> Do you have IDE? The IDE driver turned out to be the major interrupt messing
> problem on m68k, since it can disable interrupts for quite a while.

I do, but the audio latency test (which is what promoted this interest in
doing the IRQ measurement) doesn't stress the IDE (I only have a CDROM on
the IDE bus).  All the disk activity is via the AppleSCSI card.

However, I would like others with different configurations to try out the
test(s)... it's not much use if acceptable performance sound only happens on
*my* machine :-)

It's also true that all the 'little' IRQ blocks do add up - as I said when
my system is stressed up to 5% of the total elapsed time can be blocked... a
good motivation for driver writers to tune things methinks...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
