Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B3D32C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:26 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 8/8 v3] KVM: PPC: e500: Add e6500 core to Kconfig description
Date: Thu, 11 Apr 2013 13:03:14 +0300
Message-ID: <1365674594-17410-9-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
References: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add e6500 core to Kconfig description.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v3:
 - No change

 arch/powerpc/kvm/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 63c67ec..4489520 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -136,15 +136,15 @@ config KVM_E500V2
 	  If unsure, say N.
 
 config KVM_E500MC
-	bool "KVM support for PowerPC E500MC/E5500 processors"
+	bool "KVM support for PowerPC E500MC/E5500/E6500 processors"
 	depends on PPC_E500MC
 	select KVM
 	select KVM_MMIO
 	select KVM_BOOKE_HV
 	select MMU_NOTIFIER
 	---help---
-	  Support running unmodified E500MC/E5500 (32-bit) guest kernels in
-	  virtual machines on E500MC/E5500 host processors.
+	  Support running unmodified E500MC/E5500/E6500 guest kernels in
+	  virtual machines on E500MC/E5500/E6500 host processors.
 
 	  This module provides access to the hardware capabilities through
 	  a character device node named /dev/kvm.
-- 
1.7.4.1
