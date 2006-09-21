Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A824F67BB8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 08:55:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8LJVdZg012608
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 13:31:39 -0600 (MDT)
Date: Thu, 21 Sep 2006 13:11:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Include <asm/mmu.h> in arch/powerpc/sysdev/fsl_soc.h for
	phys_addr_t.
Message-ID: <20060921181152.GA32314@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch causes fsl_soc.h to import the definition of phys_addr_t
itself, rather than relying on its includer to do so.

Signed-off-by: Scott Wood <scott@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index c433d3f..5a3dd48 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -2,6 +2,8 @@ #ifndef __PPC_FSL_SOC_H
 #define __PPC_FSL_SOC_H
 #ifdef __KERNEL__
 
+#include <asm/mmu.h>
+
 extern phys_addr_t get_immrbase(void);
 
 #endif
-- 
1.4.2.1
