Date: Sun, 17 Dec 2000 17:37:21 -0800
To: linuxppc-dev@lists.linuxppc.org
Subject: TQ_ACTIVE & NFS_STALE undefined
Message-ID: <20001217173721.A15124@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Steve DuChene <sad@valinux.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When compiling the latest linuxppc_2.3 kernel from the bitkeeper
archive when it gets to the linking stage I get the following
errors:

kernel/kernel.o: In function `do_timer':
kernel/kernel.o(.text+0xd70c): undefined reference to `TQ_ACTIVE'
kernel/kernel.o(.text+0xd70c): relocation truncated to fit: R_PPC_REL24
TQ_ACTIVE
kernel/kernel.o: In function `context_thread':
kernel/kernel.o(.text+0x12df4): undefined reference to `TQ_ACTIVE'
kernel/kernel.o(.text+0x12df4): relocation truncated to fit: R_PPC_REL24
TQ_ACTIVE
fs/fs.o: In function `__nfs_revalidate_inode':
fs/fs.o(.text+0x30c5c): undefined reference to `NFS_STALE'
fs/fs.o(.text+0x30c5c): relocation truncated to fit: R_PPC_REL24 NFS_STALE
fs/fs.o(.text+0x30d7c): undefined reference to `NFS_STALE'
fs/fs.o(.text+0x30d7c): relocation truncated to fit: R_PPC_REL24 NFS_STALE
make: *** [vmlinux] Error 1

The two references to TQ_ACTIVE come from kernel/context.c and
kernel/timer.c  The reference to NFS_STALE comes from fs/nfs/inode.c
--
Steven A. DuChene	sad@valinux.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
