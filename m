Message-ID: <39B68F77.4A3FF67F@emc.com>
Date: Wed, 06 Sep 2000 14:39:51 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: entry point for linux kernel for ppc
References: <000b01c01828$0dd5d590$4d012ac7@warp-speed>
Content-Type: text/plain; charset=big5
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am reading linux boot code for powerpc.

here is what I learned:

1)  In misc.c, the zImaged kernel code is loaded to RAM and get decompressed and then
     relocated to 0x00000000.

2)  In head.S,  the boot code sets 0x00000000 = 0xdeadc0de and jump to 0x00000004(kernel)

Does anybody know where (which file and which routine) in the kernel source is this
0x00000004 corresponding to ?

Thanks,
--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
