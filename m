Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 2A98DDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 23:53:31 +1100 (EST)
Date: Thu, 15 Nov 2007 13:53:29 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] ps3: Prefix all ps3-specific kernel modules with
	`ps3-'
In-Reply-To: <Pine.LNX.4.62.0711151152290.19455@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0711151350430.24153@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0711151152290.19455@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1739455169-1195131209=:24153"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1739455169-1195131209=:24153
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

ps3: Prefix ps3-specific kernel modules with `ps3-':
  - vuart.ko -> ps3-vuart.ko
  - sys-manager.ko -> ps3-sys-manager.ko

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
As the patch was too big for linuxppc-dev, here's an alternative using `mv'

 drivers/ps3/Makefile          |    4 
 5 files changed, 1975 insertions(+), 1975 deletions(-)

mv drivers/ps3/sys-manager.c drivers/ps3/ps3-sys-manager.c
mv drivers/ps3/vuart.c drivers/ps3/ps3-vuart.c

--- a/drivers/ps3/Makefile
+++ b/drivers/ps3/Makefile
@@ -1,6 +1,6 @@
-obj-$(CONFIG_PS3_VUART) += vuart.o
+obj-$(CONFIG_PS3_VUART) += ps3-vuart.o
 obj-$(CONFIG_PS3_PS3AV) += ps3av_mod.o
 ps3av_mod-objs		+= ps3av.o ps3av_cmd.o
 obj-$(CONFIG_PPC_PS3) += sys-manager-core.o
-obj-$(CONFIG_PS3_SYS_MANAGER) += sys-manager.o
+obj-$(CONFIG_PS3_SYS_MANAGER) += ps3-sys-manager.o
 obj-$(CONFIG_PS3_STORAGE) += ps3stor_lib.o

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1739455169-1195131209=:24153--
