Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id DE88167BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2006 01:33:39 +1100 (EST)
Date: Thu, 23 Nov 2006 15:33:37 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Missed renames of CONFIG_PS3 to CONFIG_PPC_PS3
Message-ID: <Pine.LNX.4.62.0611231532390.25303@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When renaming CONFIG_PS3 to CONFIG_PPC_PS3, a few occurrences have been
missed.

I also fixed up the alignment in arch/powerpc/platforms/Makefile.

Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Index: ps3-linux-src/arch/powerpc/platforms/Makefile
===================================================================
--- ps3-linux-src.orig/arch/powerpc/platforms/Makefile	2006-11-23 13:42:46.000000000 +0100
+++ ps3-linux-src/arch/powerpc/platforms/Makefile	2006-11-23 13:42:49.000000000 +0100
@@ -5,7 +5,7 @@
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
-obj-$(CONFIG_PPC_EFIKA)          += efika/
+obj-$(CONFIG_PPC_EFIKA)		+= efika/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
@@ -14,7 +14,7 @@
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
-obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
+obj-$(CONFIG_PPC_PASEMI)	+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
-obj-$(CONFIG_PS3)		+= ps3/
+obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: ps3-linux-src/drivers/Makefile
===================================================================
--- ps3-linux-src.orig/drivers/Makefile	2006-11-23 13:42:46.000000000 +0100
+++ ps3-linux-src/drivers/Makefile	2006-11-23 13:42:49.000000000 +0100
@@ -77,4 +77,4 @@
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
-obj-$(CONFIG_PS3)		+= ps3/
+obj-$(CONFIG_PPC_PS3)		+= ps3/
Index: ps3-linux-src/include/asm-powerpc/firmware.h
===================================================================
--- ps3-linux-src.orig/include/asm-powerpc/firmware.h	2006-11-23 10:57:53.000000000 +0100
+++ ps3-linux-src/include/asm-powerpc/firmware.h	2006-11-23 15:12:45.000000000 +0100
@@ -67,7 +67,7 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_POSSIBLE |
 #endif
-#ifdef CONFIG_PS3
+#ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_POSSIBLE |
 #endif
 		0,
@@ -78,7 +78,7 @@
 #ifdef CONFIG_PPC_ISERIES
 		FW_FEATURE_ISERIES_ALWAYS &
 #endif
-#ifdef CONFIG_PS3
+#ifdef CONFIG_PPC_PS3
 		FW_FEATURE_PS3_ALWAYS &
 #endif
 		FW_FEATURE_POSSIBLE,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
