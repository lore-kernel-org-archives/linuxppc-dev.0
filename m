Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f128.google.com (mail-qy0-f128.google.com
	[209.85.221.128]) by ozlabs.org (Postfix) with ESMTP id 44834DE1E0
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 01:51:56 +1000 (EST)
Received: by qyk34 with SMTP id 34so3328775qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 08:51:55 -0700 (PDT)
Subject: [PATCH] Add a few more mpc5200 PSC defines
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Fri, 22 May 2009 11:25:10 -0400
Message-ID: <20090522152510.20037.26911.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index a218da6..fb84120 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -28,6 +28,10 @@
 #define MPC52xx_PSC_MAXNUM	6
 
 /* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR_UNEX_RX	0x0001
+#define MPC52xx_PSC_SR_DATA_VAL	0x0002
+#define MPC52xx_PSC_SR_DATA_OVR	0x0004
+#define MPC52xx_PSC_SR_CMDSEND	0x0008
 #define MPC52xx_PSC_SR_CDE	0x0080
 #define MPC52xx_PSC_SR_RXRDY	0x0100
 #define MPC52xx_PSC_SR_RXFULL	0x0200
@@ -61,6 +65,12 @@
 #define MPC52xx_PSC_RXTX_FIFO_EMPTY	0x0001
 
 /* PSC interrupt status/mask bits */
+#define MPC52xx_PSC_IMR_UNEX_RX_SLOT 0x0001
+#define MPC52xx_PSC_IMR_DATA_VALID	0x0002
+#define MPC52xx_PSC_IMR_DATA_OVR	0x0004
+#define MPC52xx_PSC_IMR_CMD_SEND	0x0008
+#define MPC52xx_PSC_IMR_ERROR		0x0040
+#define MPC52xx_PSC_IMR_DEOF		0x0080
 #define MPC52xx_PSC_IMR_TXRDY		0x0100
 #define MPC52xx_PSC_IMR_RXRDY		0x0200
 #define MPC52xx_PSC_IMR_DB		0x0400
@@ -117,6 +127,7 @@
 #define MPC52xx_PSC_SICR_SIM_FIR		(0x6 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_24		(0x7 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_32		(0xf << 24)
+#define MPC52xx_PSC_SICR_AWR			(1 << 30)
 #define MPC52xx_PSC_SICR_GENCLK			(1 << 23)
 #define MPC52xx_PSC_SICR_I2S			(1 << 22)
 #define MPC52xx_PSC_SICR_CLKPOL			(1 << 21)
