Message-ID: <39E35991.F45DF673@emc.com>
Date: Tue, 10 Oct 2000 14:01:53 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Safe shutdown on IDE boot
References: <Pine.HPX.4.10.10010101011400.16113-100000@gra-ux1.iram.es> <39E341BC.9D8FD69B@mvista.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I boot Hardhat linux on IDE disk on sp7400.

But I can boot it only once.  The next time I boot,
I see
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 284k init

and hangs there.

I put the disk back to Host and found some problem with fs on this disk
and I can fix it by "e2fsck".

I guess i had problem with safely shutdown.
Anybody knows how to do the "shutdown" safely ?

--
 Zhaobin Zhu
 zzhu@emc.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
