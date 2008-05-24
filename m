Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 9E48EDE08B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 16:11:55 +1000 (EST)
Received: from pd4mr2so.prod.shaw.ca
	(pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0K1C00LVQZVTU5B0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 24 May 2008 00:11:53 -0600 (MDT)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd4mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K1C00B9MZVTZ110@pd4mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sat, 24 May 2008 00:11:54 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0K1C00JWBZVS7800@l-daemon> for linuxppc-dev@ozlabs.org;
	Sat, 24 May 2008 00:11:52 -0600 (MDT)
Date: Sat, 24 May 2008 00:11:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] bootwrapper: add simpleImage* to list of
	boot	targets
To: linuxppc-dev@ozlabs.org, mike.koss@ngc.com, john.linn@xilinx.com,
	stephenn@xilinx.com, paulus@samba.org
Message-id: <20080524061042.25166.52276.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Without simpleImage% in the BOOT_TARGETS list, it is impossible to
build any of the simpleImages.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paulus, this is a bug fix for .26.  I'll send you a pull request early next
week with this in it if nobody sees a problem.

Cheers,
g.

 arch/powerpc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9dcdc03..86096cc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -154,7 +154,7 @@ all: zImage
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
-BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.%
+BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
 
 PHONY += $(BOOT_TARGETS)
 
