Message-ID: <39B6989A.78D6CF69@embeddededge.com>
Date: Wed, 06 Sep 2000 15:18:50 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: entry point for linux kernel for ppc
References: <000b01c01828$0dd5d590$4d012ac7@warp-speed> <39B68F77.4A3FF67F@emc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhaobin Zhu wrote:

> 2)  In head.S,  the boot code sets 0x00000000 = 0xdeadc0de and jump to 0x00000004(kernel)

There have been a few different kernel boot methods over time depending
upon how the bits were used in different systems.  The real "kernel",
vmlinux, can be booted directly in some systems.  The first couple of
words in this image (from arch/ppc/kernel/head.S) sometimes had to be
assigned particular values.  The code you mention above (from
arch/ppc/xxxxboot/head.S requires knowledge of the vmlinux format so
it can properly start the kernel when one of these alternate booting
methods is used.  As long as you don't mix these files among different
versions of software, everything should "just work".


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
