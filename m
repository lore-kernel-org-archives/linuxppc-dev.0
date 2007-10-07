Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E395DDED1
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 21:43:15 +1000 (EST)
Date: Sun, 7 Oct 2007 07:34:57 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] PPC: Remove redundant reference to non-existent
	CONFIG_BOOTIMG.
Message-ID: <Pine.LNX.4.64.0710070731410.32762@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  there is, AFAICT, no BOOTIMG Kconfig variable.  not to mention that
there is no such include/linux/bootimg.h header file.


 arch/ppc/platforms/ev64360.c |    3 ---
 arch/ppc/platforms/katana.c  |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/ppc/platforms/ev64360.c b/arch/ppc/platforms/ev64360.c
index f8baf05..6765676 100644
--- a/arch/ppc/platforms/ev64360.c
+++ b/arch/ppc/platforms/ev64360.c
@@ -23,9 +23,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
-#ifdef CONFIG_BOOTIMG
-#include <linux/bootimg.h>
-#endif
 #include <asm/page.h>
 #include <asm/time.h>
 #include <asm/smp.h>
diff --git a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
index c289e9f..52f63e6 100644
--- a/arch/ppc/platforms/katana.c
+++ b/arch/ppc/platforms/katana.c
@@ -27,9 +27,6 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
-#ifdef CONFIG_BOOTIMG
-#include <linux/bootimg.h>
-#endif
 #include <asm/io.h>
 #include <asm/unistd.h>
 #include <asm/page.h>

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================
