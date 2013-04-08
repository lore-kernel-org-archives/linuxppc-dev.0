Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews10.kpnxchange.com (cpsmtpb-ews10.kpnxchange.com
 [213.75.39.15]) by ozlabs.org (Postfix) with ESMTP id DFD2A2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 05:35:16 +1000 (EST)
Message-ID: <1365449711.1830.130.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove "config MPC10X_OPENPIC"
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Mon, 08 Apr 2013 21:35:11 +0200
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

The last users of Kconfig symbol MPC10X_OPENPIC were removed in v2.6.27.
Its Kconfig entry can be removed now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/powerpc/platforms/embedded6xx/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 5a8f50a9..302ba43 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -9,7 +9,6 @@ config LINKSTATION
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
 	select DEFAULT_UIMAGE
-	select MPC10X_OPENPIC
 	select MPC10X_BRIDGE
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
@@ -24,7 +23,6 @@ config STORCENTER
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
-	select MPC10X_OPENPIC
 	select MPC10X_BRIDGE
 	help
 	  Select STORCENTER if configuring for the iomega StorCenter
@@ -84,9 +82,6 @@ config MV64X60
 	select PPC_INDIRECT_PCI
 	select CHECK_CACHE_COHERENCY
 
-config MPC10X_OPENPIC
-	bool
-
 config GAMECUBE_COMMON
 	bool
 
-- 
1.7.11.7
