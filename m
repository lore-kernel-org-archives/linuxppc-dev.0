Return-Path: <tdent48227@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 41AA4B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Oct 2010 14:30:55 +1100 (EST)
Received: by iwn9 with SMTP id 9so814281iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 20:30:53 -0700 (PDT)
From: Tracey Dent <tdent48227@gmail.com>
To: geoff@infradead.org
Subject: [PATCH] Drivers: ps3: Makefile: replace the use of <module>-objs with
	<module>-y
Date: Fri, 15 Oct 2010 23:30:48 -0400
Message-Id: <1287199848-1902-1-git-send-email-tdent48227@gmail.com>
Cc: Tracey Dent <tdent48227@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changed <module>-objs to <module>-y in Makefile.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
---
 drivers/ps3/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ps3/Makefile b/drivers/ps3/Makefile
index ccea15c..50cb1e1 100644
--- a/drivers/ps3/Makefile
+++ b/drivers/ps3/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_PS3_VUART) += ps3-vuart.o
 obj-$(CONFIG_PS3_PS3AV) += ps3av_mod.o
-ps3av_mod-objs		+= ps3av.o ps3av_cmd.o
+ps3av_mod-y		:= ps3av.o ps3av_cmd.o
 obj-$(CONFIG_PPC_PS3) += sys-manager-core.o
 obj-$(CONFIG_PS3_SYS_MANAGER) += ps3-sys-manager.o
 obj-$(CONFIG_PS3_STORAGE) += ps3stor_lib.o
-- 
1.7.3.1.104.gc752e
