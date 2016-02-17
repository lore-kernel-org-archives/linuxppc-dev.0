Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2350B1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 17:06:17 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org,
 benh@kernel.crashing.org, Russell Currey <ruscur@russell.cc>
Subject: [PATCH] MAINTAINERS: Update EEH details and maintainership
Date: Wed, 17 Feb 2016 17:06:04 +1100
Message-Id: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enhanced Error Handling could mean anything in the context of the entire
kernel, so change the name to reference that it is both for PCI and
powerpc.

EEH covers a bit more than the previously listed files, so add the headers
and platform-specific code to the EEH maintained section.

In addition, I am taking over the maintainership.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 MAINTAINERS | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28eb61b..95d999e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4222,13 +4222,6 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
-ENHANCED ERROR HANDLING (EEH)
-M:	Gavin Shan <shangw@linux.vnet.ibm.com>
-L:	linuxppc-dev@lists.ozlabs.org
-S:	Supported
-F:	Documentation/powerpc/eeh-pci-error-recovery.txt
-F:	arch/powerpc/kernel/eeh*.c
-
 EPSON S1D13XXX FRAMEBUFFER DRIVER
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
 S:	Maintained
@@ -8244,6 +8237,15 @@ L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/PCI/pci-error-recovery.txt
 
+PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
+M:	Russell Currey <ruscur@russell.cc>
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Supported
+F:	Documentation/powerpc/eeh-pci-error-recovery.txt
+F:	arch/powerpc/kernel/eeh*.c
+F:	arch/powerpc/platforms/*/eeh*.c
+F:	arch/powerpc/include/*/eeh*.h
+
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
-- 
2.7.1
