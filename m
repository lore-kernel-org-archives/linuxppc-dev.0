Message-ID: <XFMail.000731091240.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <200007301031.LAA32665@hyperion.valhalla.net>
Date: Mon, 31 Jul 2000 09:12:40 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: Stealth port problems
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> The problem is definitely X.  I made a lot of tests: with dma and non-dma
>> serial driver, X accelerated, non accelerated, X bare.bone (started with
>> xinit). The problem is X. When X is running the serial ports looses packets
>> :-((
>> Am I the only one who is having this problem ???  Why does X cause overruns
>> ??

> If you can try 2.2.17pre10ben2 or pre13ben2 (linuxcare linux-pmac-benh) then
> you can apply the IRQ latency test and see if it is that which is blocking
> you.  Scan the dev list for "[ANN} IRQ".

I'll try a soon I have a bit of free time...

> It is possible (there was a discussion in the ANN thread about fb IRQ
> blocks) - X may aggravate this.
>
> I have seen 2ms of IRQ blocking on the Lombard (using IDE CDROM) and around
> 450-750 us of IRQ blocking on my other machines (SCSI). [when heavily
> loaded].

:-6  Why IRQ is kept locked for so much time ?

> The RX buffer in an 85230 (which is actually the chip - IIRC - an enhanced
> 8530) is 8 characters deep - so any more that about 700 us IRQ block will
> cause a drop out at 115200 continuous...

On the Amiga I used to rtx stuff at 230K with no problems. It has 1 byte
buffer...


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
