Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BBEEB6F7F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 14:36:15 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Remove linkage for sys_nfsservctl system call
Date: Tue, 30 Aug 2011 23:36:09 -0500
Message-Id: <1314765369-14486-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit didn't actually remove it from powerpc:

commit f5b940997397229975ea073679b03967932a541b
Author: NeilBrown <neilb@suse.de>
Date:   Fri Aug 26 18:03:11 2011 -0400

    All Arch: remove linkage for sys_nfsservctl system call

    The nfsservctl system call is now gone, so we should remove all
    linkage for it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/systbl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index f6736b7..fa0d27a 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -171,7 +171,7 @@ SYSCALL_SPU(setresuid)
 SYSCALL_SPU(getresuid)
 SYSCALL(ni_syscall)
 SYSCALL_SPU(poll)
-COMPAT_SYS(nfsservctl)
+SYSCALL(ni_syscall)
 SYSCALL_SPU(setresgid)
 SYSCALL_SPU(getresgid)
 COMPAT_SYS_SPU(prctl)
-- 
1.7.3.4
