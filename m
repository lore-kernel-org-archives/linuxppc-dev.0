Date: Tue, 20 May 2003 21:26:01 +0200 (CEST)
From: Mich Lanners <mlan@cpu.lu>
Subject: Re: Flash device identifier error in jedec_probe.c  
To: guo_zl9@hotmail.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Law14-OE52mmj8UMCTh0001760a@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E19ICkS-0000kO-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  20 May, this message from guo_zhenglin echoed through cyberspace:
> question 2:
> then I use:
>    cfi->mfr &=0x00FF;
>     cfi->id &=0x00FF;
> run kernel show flash size error, messages as following:
>
> Motorola MBX flash device: 800000 at fe000000
> Found: AMD AM29F016
> number of JEDEC chips: 1
                  ^^^^^^^^
Hm, one chip...

> Creating 4 MTD partitions on "MBX flash":
> 0x00000000-0x00040000 : " BOOT partition(mtd/1)"
> 0x00040000-0x00100000 : "KERNEL  partition(mtd/2)"
> 0x00100000-0x00500000 : "ROOT  partition(mtd/3)"
> mtd: partition "ROOT  partition(mtd/3)" extends beyond the end of
> device "MBX f0
> 0x00500000-0x00400000 : "APPLICATION partition(mtd/4)"
> mtd: partition "APPLICATION partition(mtd/4)" is out of reach --
> disabled
>
> My flash is 8MB, is enough.

Ah?

> 2)
>   emembedded board is MBX860 board with AM29F016 flash.

AFAIR, 29F016 is 16 Mbit... a single chip makes for 2 MB of flash
memory, not 8 MB.

I guess something's fishy with your flash memory detection.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
