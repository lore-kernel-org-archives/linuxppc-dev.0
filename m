MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: memory problems on ppc 8260 based hardware
Date: Tue, 4 May 2004 11:22:46 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DACD@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <13787783324@hnmcc.com>, <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Be aware that there is some timing problems on the SDRAM interface on
the 826x CPUs
(Look at motorolas site)
This sound very much like the problems I had before I fixed the hardware
on an inhouse board.


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]
> Sent: Tuesday, May 04, 2004 10:11
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: memory problems on ppc 8260 based hardware
>
>
>
> I'm running into  memory problems on ppc 8260 based hardware.
> The kernel is based on linux-2.4.4-2002-10-06.tar.bz2 from
www.denx.de . (use uboot as bootloader.)

I use some debug tools and find when paging_init( ) function finished
(start_kernel --setup_arch--paging_init), some codes were destroyed such
as sort_exception_table( ) (the next line in setup_arch( ), so the
kernel hang) , some codes were protected well such as memset( ). (using
LED in parallel port(adding some codes in kernel), I got the same
results,the kernel hang after paging_init( ))

what's the reason? Any advise will be appreciated.


best regards.


liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
