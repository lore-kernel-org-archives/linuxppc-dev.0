From: "Stefan Balcerczak" <Stefan.Balcerczak@marconi.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "Shoudong Xu" <Shoudong.Xu@cern.ch>,
	"Zydla Tsui" <zydla@hotmail.com>
Message-ID: <80256A38.003BE360.00@marconicomms.com>
Date: Tue, 24 Apr 2001 12:57:12 +0200
Subject: Antwort: Re: unable to mount root fs on 01:00
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I have to say sorry for the question about ip-config - it was my fault. There
was an error in the data I passed to the kernel.

The problem with mount /dev/ram as root is still unsolved and I have no idea
what to do about it ...

I tried a newer Kernel (2.4.4) but have problems with compiling:

===========================================================================================
arch/ppc/kernel/kernel.o: In function `lookup_partitions':
arch/ppc/kernel/kernel.o(.text+0x7852): undefined reference to `pmac_newworld'
arch/ppc/kernel/kernel.o(.text+0x7856): undefined reference to `pmac_newworld'
arch/ppc/kernel/kernel.o: In function `pmac_nvram_init':
arch/ppc/kernel/kernel.o(.text.init+0x554): undefined reference to
`find_devices'
arch/ppc/kernel/kernel.o(.text.init+0x554): relocation truncated to fit:
R_PPC_REL24 find_devices
arch/ppc/kernel/kernel.o(.text.init+0x588): undefined reference to
`device_is_compatible'
arch/ppc/kernel/kernel.o(.text.init+0x588): relocation truncated to fit:
R_PPC_REL24 device_is_compatible
arch/ppc/kernel/kernel.o(.text.init+0x6b6): undefined reference to `sys_ctrler'
arch/ppc/kernel/kernel.o(.text.init+0x6ba): undefined reference to `sys_ctrler'
make: *** [vmlinux] Error 1
===========================================================================================

So I play around with the "working" kernel 2.2.14 and try to get kernel 2.4.4
configured right - If anybody has a hint for me
I would be glad to hear about.

Regards,
Stefan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
