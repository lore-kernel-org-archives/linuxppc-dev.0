Message-Id: <200007310911.KAA04511@hyperion.valhalla.net>
Date: Mon, 31 Jul 2000 10:11:51 +0100
Subject: Re: Stealth port problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@shiny.it>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Mon, Jul 31, 2000,  Giuliano Pochini wrote:
>>> The problem is definitely X.  I made a lot of tests: with dma and non-dma
>>> serial driver, X accelerated, non accelerated, X bare.bone (started with
>>> xinit). The problem is X. When X is running the serial ports looses packets
>>> :-((
>>> Am I the only one who is having this problem ???  Why does X cause overruns
>>> ??
>
>> If you can try 2.2.17pre10ben2 or pre13ben2 (linuxcare linux-pmac-benh) then
>> you can apply the IRQ latency test and see if it is that which is blocking
>> you.  Scan the dev list for "[ANN} IRQ".
>
> I'll try a soon I have a bit of free time...

There's a pre-built kernel, modules & system.map (with IRQ latency &
dmasound stuff already applied ) linked to:

http://www.drfruitcake.com/linux/linuxppc.html

The IRQh app - which you need to start the profiling is linked to :

http://www.drfruitcake.com/linux/irq_blk.html

>> The RX buffer in an 85230 (which is actually the chip - IIRC - an enhanced
>> 8530) is 8 characters deep - so any more that about 700 us IRQ block will
>> cause a drop out at 115200 continuous...
>
> On the Amiga I used to rtx stuff at 230K with no problems. It has 1 byte
> buffer...

BTW st SCC-XXdma stuff *is* enabled on my G3 by default.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
