Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 10CBD680A5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 02:56:23 +1000 (EST)
Date: Wed, 24 Aug 2005 11:56:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
Message-ID: <Pine.LNX.4.61.0508241155330.23956@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 08/15] ppc32: remove use of asm/segment.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed ppc32 architecture specific users of asm/segment.h and
asm-ppc/segment.h itself

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 503a812c1f9cef08e6f96b2b2cf1f32bbfef2bc6
tree b61a93eb582e90fafda6ff9d064b2ab25e7d3ede
parent 21a31cb366a764793dc532b525b95bfc3e1723a2
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:58:02 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 24 Aug 2005 10:58:02 -0500

 arch/ppc/kernel/temp.c         |    1 -
 arch/ppc/kernel/time.c         |    1 -
 arch/ppc/platforms/chrp_time.c |    1 -
 arch/ppc/syslib/prep_nvram.c   |    1 -
 include/asm-ppc/segment.h      |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/ppc/kernel/temp.c b/arch/ppc/kernel/temp.c
--- a/arch/ppc/kernel/temp.c
+++ b/arch/ppc/kernel/temp.c
@@ -21,7 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/reg.h>
 #include <asm/nvram.h>
diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -58,7 +58,6 @@
 #include <linux/init.h>
 #include <linux/profile.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/cache.h>
diff --git a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c
+++ b/arch/ppc/platforms/chrp_time.c
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/bcd.h>
 
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/nvram.h>
 #include <asm/prom.h>
diff --git a/arch/ppc/syslib/prep_nvram.c b/arch/ppc/syslib/prep_nvram.c
--- a/arch/ppc/syslib/prep_nvram.c
+++ b/arch/ppc/syslib/prep_nvram.c
@@ -15,7 +15,6 @@
 #include <linux/ioport.h>
 
 #include <asm/sections.h>
-#include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
 #include <asm/prep_nvram.h>
diff --git a/include/asm-ppc/segment.h b/include/asm-ppc/segment.h
deleted file mode 100644
--- a/include/asm-ppc/segment.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm/uaccess.h>
