Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbnD4n3XzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 23/46] powerpc/configs: Drop CONFIG_SERIAL_TXX9_* from
 cell/ppc64
Date: Wed, 23 Aug 2017 15:37:43 +1000
Message-Id: <1503466686-10932-24-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit bf4981a00636 ("powerpc: Remove the celleb support") we
dropped the celleb support, which made these symbols unselectable
because we no longer select HAS_TX99_SERIAL. So drop them from the
defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/cell_defconfig  | 2 --
 arch/powerpc/configs/ppc64_defconfig | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index c6fb2092af38..31a7fe3ac4a8 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -147,8 +147,6 @@ CONFIG_SPIDER_NET=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_TXX9_NR_UARTS=2
-CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_HVC_RTAS=y
 CONFIG_IPMI_HANDLER=m
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index c3ff99646dcd..119273e6ba04 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -192,7 +192,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
-CONFIG_SERIAL_TXX9_CONSOLE=y
 CONFIG_SERIAL_JSM=m
 CONFIG_HVC_CONSOLE=y
 CONFIG_HVC_RTAS=y
-- 
2.7.4
