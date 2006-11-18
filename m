Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 7DD4367BD2
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 17:12:27 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Nicolas DET <nd@bplan-gmbh.de>, Paul Mackerras <paulus@samba.org>,
	Sylvain Munaut <tnt@246tNt.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Don't compile arch/powerpc mpc52xx_pic driver for
	ARCH=ppc
Date: Fri, 17 Nov 2006 23:12:14 -0700
Message-Id: <11638303343472-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/sysdev/mpc52xx_pic.c breaks the ppc build

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/sysdev/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 8ba11ab..bae8746 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -11,11 +11,11 @@ obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
-obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_pic.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
+obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_pic.o
 endif
 
 # Temporary hack until we have migrated to asm-powerpc
-- 
1.4.3.rc2.g0503
