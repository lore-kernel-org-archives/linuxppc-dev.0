Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6D37267A7B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 07:34:21 +1100 (EST)
Message-ID: <42238041.1070400@mvista.com>
Date: Mon, 28 Feb 2005 13:34:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------070604070703080602020205"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] PPC32: Add GPIO/IRQ definitions for mv64x60 parts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------070604070703080602020205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add mv64x60 GPP IO pin/IRQ register definitions

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>


--------------070604070703080602020205
Content-Type: text/plain;
 name="mv64x60_gpp_defs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64x60_gpp_defs.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/23 16:14:11+00:00 jchapman@katalix.com 
#   Add mv64x60 GPP IO pin/IRQ register definitions.
# 
# include/asm-ppc/mv64x60_defs.h
#   2005/02/23 16:14:03+00:00 jchapman@katalix.com +41 -0
#   Add mv64x60 GPP IO pin/IRQ register definitions.
# 
diff -Nru a/include/asm-ppc/mv64x60_defs.h b/include/asm-ppc/mv64x60_defs.h
--- a/include/asm-ppc/mv64x60_defs.h	2005-02-23 16:14:56 +00:00
+++ b/include/asm-ppc/mv64x60_defs.h	2005-02-23 16:14:56 +00:00
@@ -43,6 +43,10 @@
 #define	MV64x60_IRQ_TIMER_2_3			9
 #define	MV64x60_IRQ_TIMER_4_5			10
 #define	MV64x60_IRQ_TIMER_6_7			11
+#define	MV64x60_IRQ_P1_GPP_0_7			24
+#define	MV64x60_IRQ_P1_GPP_8_15			25
+#define	MV64x60_IRQ_P1_GPP_16_23		26
+#define	MV64x60_IRQ_P1_GPP_24_31		27
 #define	MV64x60_IRQ_DOORBELL			28
 #define	MV64x60_IRQ_ETH_0			32
 #define	MV64x60_IRQ_ETH_1			33
@@ -53,11 +57,48 @@
 #define	MV64x60_IRQ_MPSC_0			40
 #define	MV64x60_IRQ_MPSC_1			42
 #define	MV64x60_IRQ_COMM			43
+#define	MV64x60_IRQ_P0_GPP_0_7			56
+#define	MV64x60_IRQ_P0_GPP_8_15			57
+#define	MV64x60_IRQ_P0_GPP_16_23		58
+#define	MV64x60_IRQ_P0_GPP_24_31		59
 
 #define	MV64360_IRQ_PCI0			12
 #define	MV64360_IRQ_SRAM_PAR_ERR		13
 #define	MV64360_IRQ_PCI1			16
 #define	MV64360_IRQ_SDMA_1			38
+
+#define	MV64x60_IRQ_GPP0			64
+#define	MV64x60_IRQ_GPP1			65
+#define	MV64x60_IRQ_GPP2			66
+#define	MV64x60_IRQ_GPP3			67
+#define	MV64x60_IRQ_GPP4			68
+#define	MV64x60_IRQ_GPP5			69
+#define	MV64x60_IRQ_GPP6			70
+#define	MV64x60_IRQ_GPP7			71
+#define	MV64x60_IRQ_GPP8			72
+#define	MV64x60_IRQ_GPP9			73
+#define	MV64x60_IRQ_GPP10			74
+#define	MV64x60_IRQ_GPP11			75
+#define	MV64x60_IRQ_GPP12			76
+#define	MV64x60_IRQ_GPP13			77
+#define	MV64x60_IRQ_GPP14			78
+#define	MV64x60_IRQ_GPP15			79
+#define	MV64x60_IRQ_GPP16			80
+#define	MV64x60_IRQ_GPP17			81
+#define	MV64x60_IRQ_GPP18			82
+#define	MV64x60_IRQ_GPP19			83
+#define	MV64x60_IRQ_GPP20			84
+#define	MV64x60_IRQ_GPP21			85
+#define	MV64x60_IRQ_GPP22			86
+#define	MV64x60_IRQ_GPP23			87
+#define	MV64x60_IRQ_GPP24			88
+#define	MV64x60_IRQ_GPP25			89
+#define	MV64x60_IRQ_GPP26			90
+#define	MV64x60_IRQ_GPP27			91
+#define	MV64x60_IRQ_GPP28			92
+#define	MV64x60_IRQ_GPP29			93
+#define	MV64x60_IRQ_GPP30			94
+#define	MV64x60_IRQ_GPP31			95
 
 /* Offsets for register blocks */
 #define	GT64260_ENET_PHY_ADDR			0x2000

--------------070604070703080602020205--
