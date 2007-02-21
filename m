Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BE4D5DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 14:53:16 +1100 (EST)
Date: Wed, 21 Feb 2007 14:53:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] allocate syscall number for sys_getcpu
Message-Id: <20070221145350.6a5b37fe.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I forgot to do this when wiring up the syscall.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/unistd.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 0ae954e..bcc21bf 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -324,10 +324,11 @@
 #define __NR_get_robust_list	299
 #define __NR_set_robust_list	300
 #define __NR_move_pages		301
+#define __NR_getcpu		302
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		302
+#define __NR_syscalls		303
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.4.4.4
