Message-ID: <39DCF004.99724F4D@mvista.com>
Date: Thu, 05 Oct 2000 14:17:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot failed on Sandpoint under baudrate 38400
References: <39DCEA5A.2E9DDE3C@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What do you mean by garbled?  Do you mean the characters look okay but some
seem to be missing or just a bunch of strange characters?

The kernel, the bootloader, and DINK all need to be set up for the same baud
rate.  It sounds like you have dink and the bootloader setup for one baud rate
and the kernel is probably still at 9600.  Could that be the case?

Mark

> Hi,
>
> Anybody tried booting Hardhat linux on Sandpoint/603e/755/7400
> under Baudrate 38400 ?
>
> On my sp7400, the boot is ok under 9600, but gives garbled message
> after "Now booting the kernel" under 38400.
>
> I change baudrate in arch/ppc/boot/ns16550.c
>
> Does the kernel change the baudrate in other place ?
>
> Thanks,
>
> --
>  Zhaobin Zhu
>  zzhu@emc.com
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
