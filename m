Message-ID: <38DDCE18.893813BD@iiic.ethz.ch>
Date: Sun, 26 Mar 2000 10:45:12 +0200
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.05.10003251547440.11621-100000@callisto.of.borg>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> fix.smem_start is unsigned long, which is 64-bit on all 64-bit platforms.
>
> Please tell me where you're hiding that 32-bit box with 64-bit PCI
> addressing inside :-)
>
> Anyway, it's perfectly possible to do it correctly _now_ on 32-bit boxes
> with 32-bit PCI addressing and on all 64-bit boxes, so I see no reason for
> breaking the game for those.

I shouldn't have opened my mouth about something I don't really know about,
I'll just cite Jeff from a linux-fbdev post:

> The server obtains a list of hardware from scanning the PCI bus.  It
> needs to know which devices are attached to framebuffer devices, and
> which are not, in order to know whether to use a bit-banging interface
> or an fbdev interface.
>
> Currently the only way to do this is a hueristic which takes
> fix.smem_start and determines in which PCI BAR the address falls.  This
> is insufficient for 64-bit machines, and also generally ugly :)


In another post he was talking about the problem being 32 bit PCI busses on 64
bit machines.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
