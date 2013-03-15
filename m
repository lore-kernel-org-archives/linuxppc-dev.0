Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AA3D2C007A
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Mar 2013 03:15:57 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r2FGFrXu023685
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Mar 2013 11:15:54 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/qe: Fix Kconfig enablement of QE_USB support
Date: Fri, 15 Mar 2013 11:15:53 -0500
Message-Id: <1363364153-25427-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b changed the USB gadget
Kconfig symbol from USB_GADGET_FSL_QE to USB_FSL_QE, but did not update
the associated symbol name in qe_lib to match.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/qe_lib/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 41ac3df..3c25199 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -22,6 +22,6 @@ config UCC
 
 config QE_USB
 	bool
-	default y if USB_GADGET_FSL_QE
+	default y if USB_FSL_QE
 	help
 	  QE USB Controller support
-- 
1.7.9.7
