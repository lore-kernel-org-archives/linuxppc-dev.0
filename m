Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCBF1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 2/6] powerpc/kconfig: Move sysdev Kconfig later
Date: Fri,  9 Oct 2015 08:09:13 +1100
Message-Id: <1444338557-14988-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Things in sysdev are generally not what we want near the top of the
menuconfig, so move them down later in the list.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c6f1aa1e8d4c..db685fa54c5f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -302,7 +302,6 @@ source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
 
-source "arch/powerpc/sysdev/Kconfig"
 source "arch/powerpc/platforms/Kconfig"
 
 menu "Kernel options"
@@ -1079,6 +1078,7 @@ source "arch/powerpc/sysdev/qe_lib/Kconfig"
 source "lib/Kconfig"
 
 source "arch/powerpc/Kconfig.debug"
+source "arch/powerpc/sysdev/Kconfig"
 
 source "security/Kconfig"
 
-- 
2.1.4
