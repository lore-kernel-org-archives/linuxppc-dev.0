Message-ID: <39CB7EF3.11FD1718@emc.com>
Date: Fri, 22 Sep 2000 11:46:59 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Sandpoint/PPMC750 MPPMC7400
References: <LAW2-F270jsGwPAj0fc00002e91@hotmail.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I has been trying to boot Hardhat (CDK1.2)linux kernel on
Sandpoint/PPMC750. Everytime the boot gets stuck at
.......
>Uncompressing Linux...done.
>Now booting the kernel

I replaced the PPMC750 with an PPMC7400 and boot the same code,
the boot went all the way through until

.....
>Kernel panic: I have no root and I want to scream
>Rebooting in 180 seconds..

Does anybody know where the kernel could possibly be hanging (for PPMC750) ?

Also what COP-based debug tools are available for PPMC750/7400 on sandpoint.
Somebody mentioned Arbitron and EST.
Did anybody have experience with them and what you recommend ?

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
