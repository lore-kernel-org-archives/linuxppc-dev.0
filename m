Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-01.ptn.no (pt20-qms-01.ptn.no [64.28.25.138])
	by ozlabs.org (Postfix) with SMTP id 13F3E67A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 00:03:08 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFAFAEBEE5.967C7189-ONC1256FA8.0046506F-C1256FA8.00471593@axxessit.no>
From: morten.banzon@axxessit.no
Date: Mon, 14 Feb 2005 13:56:07 +0100
Content-Type: text/plain; charset="us-ascii"
Subject: [PATCH][PPC32] Adds mcc cpm commands
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch adds mcc cpm commands to the cpm2.h file in the 2.6.10 kernel

Signed-off-by:  Morten Banzon  <morten.banzon at axxessit.no>


diff -Nru linux-2.6.10.orig/include/asm-ppc/cpm2.h 
linux-2.6.10/include/asm-ppc/cpm2.h
--- linux-2.6.10.orig/include/asm-ppc/cpm2.h    2004-12-24 
22:34:44.000000000 +0100
+++ linux-2.6.10/include/asm-ppc/cpm2.h 2005-02-14 12:22:22.000000000 
+0100
@@ -41,6 +41,7 @@
 #define CPM_CR_IDMA3_SBLOCK    (0x16)
 #define CPM_CR_IDMA4_SBLOCK    (0x17)
 #define CPM_CR_MCC1_SBLOCK     (0x1c)
+#define CPM_CR_MCC2_SBLOCK     (0x1d)
 
 #define CPM_CR_SCC1_PAGE       (0x00)
 #define CPM_CR_SCC2_PAGE       (0x01)
@@ -68,10 +69,15 @@
 #define CPM_CR_INIT_RX         ((ushort)0x0001)
 #define CPM_CR_INIT_TX         ((ushort)0x0002)
 #define CPM_CR_HUNT_MODE       ((ushort)0x0003)
+#define CPM_CR_INIT_MCC_TRX    ((ushort)0x0003)
 #define CPM_CR_STOP_TX         ((ushort)0x0004)
+#define CPM_CR_INIT_MCC_TX     ((ushort)0x0005)
+#define CPM_CR_INIT_MCC_RX     ((ushort)0x0006)
 #define CPM_CR_RESTART_TX      ((ushort)0x0006)
+#define CPM_CR_MCC_RESET       ((ushort)0x0007)
 #define CPM_CR_SET_GADDR       ((ushort)0x0008)
 #define CPM_CR_START_IDMA      ((ushort)0x0009)
+#define CPM_CR_STOP_RX         ((ushort)0x0009)
 #define CPM_CR_STOP_IDMA       ((ushort)0x000b)
 
 #define mk_cr_cmd(PG, SBC, MCN, OP) \
