From: Benjamin Herrenschmidt <benh@mipsys.com>
To: Christof Petig <christof.petig@wtal.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.2.17pre9-ben1 gmac problems on iBook
Date: Tue, 4 Jul 2000 12:18:05 +0200
Message-Id: <20000704101805.530@mailhost.mipsys.com>
In-Reply-To: <3961B34E.DE400323@wtal.de>
References: <3961B34E.DE400323@wtal.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>after some problems with linuxcare.com.au's current kernel I was glad to
>see your
>announcement.
>But your new gmac driver still has the same problem for me:
>
>Once the card is activated (and a network cable plugged in) the machine
>tells me
>   eth0: Duplicate entry of the interrupt handler !
>six or seven times and then goes into kernel debugger (which simply
>garbages my
>screen)
>
>Hardware:
>iBook 300MHz, 192MB, ATI Rage 3D Mobility AGPx2 (or so) [4c4e], BootX
>
>Christof
>
>PS: I have never been able to boot any 2.3+ kernels since I get a bunch of
>DMA timeouts. Perhaps the kernel arguments?
>    ide0=noautotune idebus=66
>Though I tried some variants (empty line and more) last time without any
>success.
>What changed, though, is that it can read my partition table (around
>March, 10th?
>the 2.3.x kernel wasn't able to do that)

Which bootloader are you using ? I suspect you are using BootX. The
kernel is not reliable when using it, you should be using yaboot.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
