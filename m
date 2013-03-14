Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5]) by ozlabs.org (Postfix) with ESMTP id C03152C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 02:15:02 +1100 (EST)
Message-ID: <1363274097.1335.83.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove "config 8260_PCI9"
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Thu, 14 Mar 2013 16:14:57 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The last user of Kconfig symbol 8260_PCI9 got removed in release v3.2.
Remove this symbol too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Untested.

1) This probably is a second order effect of my commit
6805ab6daa2b589fe3242d05ddc47a9dbb0c4eb1 ("powerpc: drop unused Kconfig
symbols"). Not sure how I missed that.

 arch/powerpc/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b89d7eb..8014a44 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -774,11 +774,6 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-config 8260_PCI9
-	bool "Enable workaround for MPC826x erratum PCI 9"
-	depends on PCI_8260 && !8272
-	default y
-
 source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
-- 
1.7.11.7
