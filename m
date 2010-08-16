Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1DA5EB70A7
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 18:27:08 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix typo in uImage target
Date: Mon, 16 Aug 2010 10:26:56 +0200
Message-Id: <1281947216-15342-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, Sam Ravnborg <sam@ravnborg.org>,
	stable <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit e32e78c5ee8aadef020fbaecbe6fb741ed9029fd
(powerpc: fix build with make 3.82) introduced a
typo in uImage target and broke building uImage:

make: *** No rule to make target `uImage'.  Stop.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: stable <stable@kernel.org>
---
 arch/powerpc/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index e3ea151..b7212b6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -164,7 +164,7 @@ drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 all: zImage
 
 # With make 3.82 we cannot mix normal and wildcard targets
-BOOT_TARGETS1 := zImage zImage.initrd uImaged
+BOOT_TARGETS1 := zImage zImage.initrd uImage
 BOOT_TARGETS2 := zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
 
 PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
-- 
1.7.0.4
