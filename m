Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32E0B1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 23:06:18 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/eeh: rename EEH from "extended" to "enhanced" error
 handling
Date: Tue, 16 Feb 2016 23:06:05 +1100
Message-Id: <1455624365-4200-1-git-send-email-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

IBM online documentation for EEH uses "extended error handling" and
"enhanced error handling" to refer to the same thing, in different
places.  The only place mentioning it as "enhanced error handling" in the
kernel is the MAINTAINERS file, and it's "extended" in some documentation.

IBM originally defined EEH as "enhanced error handling", so standardise
all mentions of EEH to use that term.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
This is essentially a V2 (though it has the inverse result) of this patch:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-February/139367.html
---
 Documentation/powerpc/eeh-pci-error-recovery.txt | 2 +-
 arch/powerpc/kernel/eeh.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
index 9d4e33d..6781892 100644
--- a/Documentation/powerpc/eeh-pci-error-recovery.txt
+++ b/Documentation/powerpc/eeh-pci-error-recovery.txt
@@ -12,7 +12,7 @@ Overview:
 The IBM POWER-based pSeries and iSeries computers include PCI bus
 controller chips that have extended capabilities for detecting and
 reporting a large variety of PCI bus error conditions.  These features
-go under the name of "EEH", for "Extended Error Handling".  The EEH
+go under the name of "EEH", for "Enhanced Error Handling".  The EEH
 hardware features allow PCI bus errors to be cleared and a PCI
 card to be "rebooted", without also having to reboot the operating
 system.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 40e4d4a..2e78466 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -48,7 +48,7 @@
 
 
 /** Overview:
- *  EEH, or "Extended Error Handling" is a PCI bridge technology for
+ *  EEH, or "Enhanced Error Handling" is a PCI bridge technology for
  *  dealing with PCI bus errors that can't be dealt with within the
  *  usual PCI framework, except by check-stopping the CPU.  Systems
  *  that are designed for high-availability/reliability cannot afford
-- 
2.7.1
