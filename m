Message-ID: <396201D1.B43A97F1@wtal.de>
Date: Tue, 04 Jul 2000 17:25:05 +0200
From: Christof Petig <christof.petig@wtal.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@mipsys.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.17pre9-ben1 gmac problems on iBook
References: <3961B34E.DE400323@wtal.de> <20000704101805.530@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >
> >after some problems with linuxcare.com.au's current kernel I was glad to
> >see your
> >announcement.
> >But your new gmac driver still has the same problem for me:
> >
> >Once the card is activated (and a network cable plugged in) the machine
> >tells me
> >   eth0: Duplicate entry of the interrupt handler !
> >six or seven times and then goes into kernel debugger (which simply
> >garbages my
> >screen)
> >
> >Hardware:
> >iBook 300MHz, 192MB, ATI Rage 3D Mobility AGPx2 (or so) [4c4e], BootX
> >
> >Christof
> >
> >PS: I have never been able to boot any 2.3+ kernels since I get a bunch of
> >DMA timeouts. Perhaps the kernel arguments?
> >    ide0=noautotune idebus=66
> >Though I tried some variants (empty line and more) last time without any
> >success.
> >What changed, though, is that it can read my partition table (around
> >March, 10th?
> >the 2.3.x kernel wasn't able to do that)
>
> Which bootloader are you using ? I suspect you are using BootX. The
> kernel is not reliable when using it, you should be using yaboot.
>
> Ben.

You're right.
Strange though that BootX gives this kind of weird behaviour (2.2.15pre14
works fine for me).
I'll report about yaboot soon.

Christof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
