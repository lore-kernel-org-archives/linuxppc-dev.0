Message-Id: <4.3.2.7.0.20000627170916.00acd3c0@10.0.0.2>
Date: Tue, 27 Jun 2000 17:10:10 -0400
To: Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
From: Mike Coy <coym@embeddedplanet.com>
Subject: RE: PCMCIA ATA flash support
In-Reply-To: <A109131318C4D1119AC20060088DECE30B9826@amwmail.adaptivemic
 ro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yep, it has an __init for me too.   Interesting.

Good eyes!
mike

At 04:59 PM 6/27/00, Lucinda Schafer wrote:
>I noticed an __init in front of m8xx_ide_init_hwif_ports.
>
>According to init.h:
>
>/* These macros are used to mark some functions or
>  * initialized data (doesn't apply to uninitialized data)
>  * as `initialization' functions. The kernel can take this
>  * as hint that the function is used only during the initialization
>  * phase and free up used memory resources after
>  *
>  * Usage:
>
>If you are calling ide_register() after bootup, could this be a problem
>(note: I am using 2.2.13 with no patches for the PCMCIA so this may not be
>true in your case)?
>
>However, if your function is missing, this could be your problem.
>
>Maybe one of the more experienced "listees" could give a better answer.
>
>
>Lucinda Schafer
>Staff Software Engineer
>Adaptive Micro-Ware, Inc.
>
>
>
>-----Original Message-----
>From: Mike Coy [mailto:coym@embeddedplanet.com]
>Sent: Tuesday, June 27, 2000 2:58 PM
>To: Lucinda Schafer; linuxppc-embedded@lists.linuxppc.org
>Subject: RE: PCMCIA ATA flash support
>
>
>
>NIP is c00def58 (m8xx_ide_init_hwif_ports)
>LR is c0002da4 (inside ide_init_hwif_ports)
>
>I gather that LR is the place you were called from and NIP is the next
>instruction, in which case both of these seem to be correct.
>
>mike
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
