Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 889E2679E2
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 18:38:14 +1000 (EST)
Date: Sun, 24 Sep 2006 10:38:10 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] enable sysrq in pmac32_defconfig
Message-ID: <20060924083810.GA8524@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Enable sysrq also for pmac32

Signed-off-by: Olaf Hering <olaf@aepfle.de>

Index: linux-2.6/arch/powerpc/configs/pmac32_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/pmac32_defconfig
+++ linux-2.6/arch/powerpc/configs/pmac32_defconfig
@@ -1826,7 +1826,7 @@ CONFIG_OPROFILE=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
-# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=14
