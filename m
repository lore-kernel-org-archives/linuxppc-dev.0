Message-ID: <283683437.06489@hnmcc.com>
From: "" <13787783324@hnmcc.com>
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 04 May 2004 23:10:37 +0800
Reply-To: "" <13787783324@hnmcc.com>
Subject: memory problems on ppc 8260 based hardware
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm running into  memory problems on ppc 8260 based hardware. The kernel is based
on linux-2.4.4-2002-10-06.tar.bz2 from www.denx.de . (use uboot as bootloader.)

I use some debug tools and find when paging_init( ) function finished
(start_kernel --setup_arch--paging_init), some codes were destroyed such as
sort_exception_table( ) (the next line in setup_arch( ), so the kernel hang) ,
some codes were protected well such as memset( ).
(using LED in parallel port(adding some codes in kernel), I got the same
results,the kernel hang after paging_init( ))

what's the reason? Any advise will be appreciated.


best regards.


liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
