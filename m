Return-Path: <b08248@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BCCE0DDE16
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 04:30:34 +1100 (EST)
Date: Fri, 16 Feb 2007 11:30:29 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702161730.l1GHUTDJ006649@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: remove references to the obsolete linux,
	platform property
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove references to the linux,platform property from
booting-without-of.txt since it is obsolete.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 3b51467..b2ab388 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -509,7 +509,6 @@ looks like in practice.
       o chosen
         |- name = "chosen"
         |- bootargs = "root=/dev/sda2"
-        |- linux,platform = <00000600>
         |- linux,phandle = <4>
 
 This tree is almost a minimal tree. It pretty much contains the
@@ -733,8 +732,7 @@ address which can extend beyond that lim
       that typically get driven by the same platform code in the
       kernel, you would use a different "model" property but put a
       value in "compatible". The kernel doesn't directly use that
-      value (see /chosen/linux,platform for how the kernel chooses a
-      platform type) but it is generally useful.
+      value but it is generally useful.
 
   The root node is also generally where you add additional properties
   specific to your board like the serial number if any, that sort of
@@ -843,11 +841,6 @@ address which can extend beyond that lim
   the prom_init() trampoline when booting with an OF client interface,
   but that you have to provide yourself when using the flattened format.
 
-  Required properties:
-
-    - linux,platform : This is your platform number as assigned by the
-      architecture maintainers
-
   Recommended properties:
 
     - bootargs : This zero-terminated string is passed as the kernel
-- 
1.4.4
