From: Jim Thompson <jim@SmallWorks.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15347.38520.794597.215495@zaphod.musenki.com>
Date: Thu, 15 Nov 2001 04:18:32 -0600
To: Shie Erlich <shie_e@elbit.co.il>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: a general bootloader question
In-Reply-To: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
References: <937610FE9B70D511B3E700508B8B65770E53B1@MAIL1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> if anyone can help with the following question, i'd be really grateful:
>
> 1) what is the proper way to get the kernel to boot - do i need a
> bootloader, if so, what ?

ppcboot or gbios are two good starting points for a bootloader.

ppcboot: http://ppcboot.sourceforge.net/
gbios: http://www.humboldt.co.uk/gbios.html

there is also dink32 from motorola.

> 2) what is the bootloader's functionality - except downloading the kernel ?
> does it modify
>     memory in any way ? is the kernel dependent on such modifications ?

typically it turns on the memory system, sets up an environment for
the kernel, moves the kernel into ram (over serial, ethernet or out of
flash/rom) and then transfers control to the kernel (or the routine
that decompresses the kernel)

> 3) how can i make a bootloader load the kernel in low memory without
> changing KERNELBASE etc ?

See #1.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
