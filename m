Message-ID: <39DCF22E.7B0EB22C@emc.com>
Date: Thu, 05 Oct 2000 17:27:10 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
To: mgreer@mvista.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot failed on Sandpoint under baudrate 38400
References: <39DCEA5A.2E9DDE3C@emc.com> <39DCF004.99724F4D@mvista.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:

> What do you mean by garbled?  Do you mean the characters look okay but some
> seem to be missing or just a bunch of strange characters?
>

 a bunch of strange characters.

>
> The kernel, the bootloader, and DINK all need to be set up for the same baud
> rate.  It sounds like you have dink and the bootloader setup for one baud rate
> and the kernel is probably still at 9600.  Could that be the case?
>
> Mark
>

Yes, I set bootloader(arch/ppc/boot/ns16550.c)  and DINK (sb -k 38400) to 38400.
So where do I change the baud rate for kernel ?

Thanks,
--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
