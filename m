Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bf6v3p3DzF2TC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:21:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] powerpc/syscalls: timer_create can be handle by perfectly
 normal COMPAT_SYS_SPU
Date: Wed,  2 May 2018 23:20:51 +1000
Message-Id: <20180502132051.28861-6-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/systbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index cdf528089a63..79a3b47e4839 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -245,7 +245,7 @@ SYSCALL_SPU(epoll_create)
 SYSCALL_SPU(epoll_ctl)
 SYSCALL_SPU(epoll_wait)
 SYSCALL_SPU(remap_file_pages)
-SYSX_SPU(sys_timer_create,compat_sys_timer_create,sys_timer_create)
+COMPAT_SYS_SPU(timer_create)
 COMPAT_SYS_SPU(timer_settime)
 COMPAT_SYS_SPU(timer_gettime)
 SYSCALL_SPU(timer_getoverrun)
-- 
2.14.1
