Message-Id: <200008022120.WAA28589@hyperion.valhalla.net>
Date: Wed, 02 Aug 2000 22:16:25 +0100
Subject: rtc 2.4.0 ksyms again...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

 could someone (who can) put this into the bk-tree so that the paranoid
amongst us can build rtc.o as a module...

--- bk-devel/arch/ppc/kernel/ppc_ksyms.c Sun Jul 16 08:00:19 2000
+++ linux-2.4.0-t5-wrk/arch/ppc/kernel/ppc_ksyms.c Wed Aug  2 22:33:16 2000
@@ -254,7 +254,7 @@
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
 #endif /* CONFIG_NVRAM */
-#ifdef CONFIG_PPC_RTC
+#ifdef CONFIG_PPC_RTC_MODULE
 EXPORT_SYMBOL(mktime);
 EXPORT_SYMBOL(to_tm);
 #endif


thanks,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
