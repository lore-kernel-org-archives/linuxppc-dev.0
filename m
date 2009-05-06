Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B6E5ADDFB0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:15:27 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/12] mpc5121: Added reset module registers representation.
Date: Wed,  6 May 2009 22:15:11 +0200
Message-Id: <1241640919-4650-5-git-send-email-wd@denx.de>
In-Reply-To: <1241640919-4650-1-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Piotr Ziecik <kosmo@semihalf.com>

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/include/asm/mpc512x.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc512x.h b/arch/powerpc/include/asm/mpc512x.h
index c48a165..ea50d8d 100644
--- a/arch/powerpc/include/asm/mpc512x.h
+++ b/arch/powerpc/include/asm/mpc512x.h
@@ -16,6 +16,19 @@
 #ifndef __ASM_POWERPC_MPC512x_H__
 #define __ASM_POWERPC_MPC512x_H__
 
+/* MPC512x Reset module registers */
+struct mpc512x_reset_module {
+	u32	rcwlr;	/* Reset Configuration Word Low Register */
+	u32	rcwhr;	/* Reset Configuration Word High Register */
+	u32	reserved1;
+	u32	reserved2;
+	u32	rsr;	/* Reset Status Register */
+	u32	rmr;	/* Reset Mode Register */
+	u32	rpr;	/* Reset Protection Register */
+	u32	rcr;	/* Reset Control Register */
+	u32	rcer;	/* Reset Control Enable Register */
+} __attribute__ ((__packed__));
+
 extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
 
 #endif /* __ASM_POWERPC_MPC512x_H__ */
-- 
1.6.0.6
