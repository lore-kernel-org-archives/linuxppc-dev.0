In-Reply-To: <001201c489f6$926db540$5201a8c0@GEG2400>
References: <001201c489f6$926db540$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <C9701947-F5F7-11D8-B036-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: MPC8560 boot console (CPM SCC) driver problem
Date: Tue, 24 Aug 2004 13:02:39 -0500
To: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 24, 2004, at 11:22 AM, Gérard Guével wrote:

>
> Hi,
>
> I download a 2.6.8 Linux kernel to port it to a custom 8560 board
> similar to MPC8560_ADS board..
>
> In the arch/ppc/boot directory there is no 85xx_io directory with
> a CPM uart driver.
>
> The kernel link waits for some serial basic functions like
> serial_getc().
>
> I found the generic ./drivers/serial/cpm_uart driver, but it seems to
> only
> be
> used later when Linux is installed.
>
> Surely I miss something.
> How can I have a console for my boot ?
> Are 8260 cpm2 definitions compatible with 85xx ?

The common boot code in the kernel has not been ported to e500 or 85xx.
Thus the lack of proper serial support for the 8560.  I would recommend
using u-boot as the boot loader.  U-boot already has support for the
8560 and several boards.

- kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
