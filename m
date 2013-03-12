Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CFF82C0296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 07:03:54 +1100 (EST)
Date: Tue, 12 Mar 2013 15:03:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: add CONFIG_E1000E to corenet64_smp_defconfig
Message-ID: <20130312200340.GA22145@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a commonly used ethernet card, especially with mainline kernels
which lack datapath support.o

Other changes are due to running savedefconfig.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---

 arch/powerpc/configs/corenet64_smp_defconfig |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 3d139fa..37363a3 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -1,14 +1,12 @@
 CONFIG_PPC64=y
 CONFIG_PPC_BOOK3E_64=y
-# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
-CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -78,6 +76,7 @@ CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_E1000E=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -140,6 +139,5 @@ CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_SHA256=y
 CONFIG_CRYPTO_SHA512=y
-CONFIG_CRYPTO_AES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
-- 
1.7.9.5
