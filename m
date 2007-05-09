Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 921D1DDE41
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:32:30 +1000 (EST)
Date: Wed, 9 May 2007 17:32:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/2] [POWERPC] Wire up sys_utimensat
Message-Id: <20070509173233.d130e2de.sfr@canb.auug.org.au>
In-Reply-To: <20070509173054.54f2e137.sfr@canb.auug.org.au>
References: <20070509162151.6a54507a.sfr@canb.auug.org.au>
	<20070509162442.11760e79.sfr@canb.auug.org.au>
	<20070509064203.GY18236@moe.telargo.com>
	<20070509173054.54f2e137.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Domen Puncer <domen.puncer@telargo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/systbl.h |    1 +
 include/asm-powerpc/unistd.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 0b00068..3d44446 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -307,3 +307,4 @@ COMPAT_SYS_SPU(set_robust_list)
 COMPAT_SYS_SPU(move_pages)
 SYSCALL_SPU(getcpu)
 COMPAT_SYS(epoll_pwait)
+COMPAT_SYS_SPU(utimensat)
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 2baedbe..21f004a 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -326,10 +326,11 @@
 #define __NR_move_pages		301
 #define __NR_getcpu		302
 #define __NR_epoll_pwait	303
+#define __NR_utimensat		304
 
 #ifdef __KERNEL__
 
-#define __NR_syscalls		304
+#define __NR_syscalls		305
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
-- 
1.5.1.3
