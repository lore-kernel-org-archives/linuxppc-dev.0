Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 05F3BDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 01:33:38 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so291750yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 07:33:37 -0700 (PDT)
Date: Fri, 24 Oct 2008 10:31:58 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/40x: Don't enable HCU4 board by default
Message-ID: <20081024143158.GA13766@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the HCU4 Kconfig option to 'default n'.  We don't want the
board to always be enabled for other board defconfigs.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 6573027..14e027f 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -35,7 +35,7 @@ config EP405
 config HCU4
 	bool "Hcu4"
 	depends on 40x
-	default y
+	default n
 	select 405GPR
 	help
 	  This option enables support for the Nestal Maschinen HCU4 board.
