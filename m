Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 3CF8667A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:54:18 +1100 (EST)
Subject: Re: [PATCH 6/6] MTD defines for Luan
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141257179.25758.31.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
	<1141256751.25761.19.camel@rhino.az.mvista.com>
	<1141256859.25758.22.camel@rhino.az.mvista.com>
	<1141257021.25761.26.camel@rhino.az.mvista.com>
	<1141257084.25758.28.camel@rhino.az.mvista.com>
	<1141257179.25758.31.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-iMI9whtrDIb/CxV6phRY"
Message-Id: <1141257255.25758.34.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:54:15 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-iMI9whtrDIb/CxV6phRY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes the defines for MTD support in the Luan platform file.

--Wade

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-iMI9whtrDIb/CxV6phRY
Content-Disposition: attachment; filename=luan-mtd-defs.patch
Content-Type: text/x-patch; name=luan-mtd-defs.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/luan.h b/arch/ppc/platforms/4xx/luan.h
--- a/arch/ppc/platforms/4xx/luan.h
+++ b/arch/ppc/platforms/4xx/luan.h
@@ -32,14 +32,28 @@
 #define LUAN_TMR_CLK		25000000
 
 /* Flash */
-#define LUAN_FPGA_REG_0			0x0000000148300000ULL
+#define LUAN_FPGA_REG_0			0x00000001f8000000ULL
+#define LUAN_CONFIG_MASK		0x43
+#define LUAN_CONFIG_1			0x41
+#define LUAN_CONFIG_2			0x40
+#define LUAN_CONFIG_3			0x01
+#define LUAN_CONFIG_4			0x00
 #define LUAN_BOOT_LARGE_FLASH(x)	(x & 0x40)
-#define LUAN_SMALL_FLASH_LOW		0x00000001ff900000ULL
-#define LUAN_SMALL_FLASH_HIGH		0x00000001ffe00000ULL
+#define LUAN_SMALL_FLASH_LOW		0x00000001f9900000ULL
+#define LUAN_SMALL_FLASH_LOW4		0x00000001f9800000ULL
+#define LUAN_SMALL_FLASH_HIGH		0x00000001fff00000ULL
+#define LUAN_SMALL_FLASH_HIGH2		0x00000001ffe00000ULL
 #define LUAN_SMALL_FLASH_SIZE		0x100000
-#define LUAN_LARGE_FLASH_LOW		0x00000001ff800000ULL
+#define LUAN_LARGE_FLASH_LOW		0x00000001f9800000ULL
 #define LUAN_LARGE_FLASH_HIGH		0x00000001ffc00000ULL
 #define LUAN_LARGE_FLASH_SIZE		0x400000
+#define LUAN_SRAM_HIGH			0x00000001ffe00000ULL
+#define LUAN_SRAM_HIGH2			0x00000001fff00000ULL
+#define LUAN_SRAM_LOW			0x00000001f9800000ULL
+#define LUAN_SRAM_LOW4			0x00000001f9900000ULL
+#define LUAN_SRAM_SIZE			0x100000
+#define LUAN_FRAM_ADDR			0x00000001f8060000ULL
+#define LUAN_FRAM_SIZE			0x8000
 
 /*
  * Serial port defines

--=-iMI9whtrDIb/CxV6phRY--
