Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 834A968679
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 06:53:31 +1100 (EST)
Date: Mon, 7 Nov 2005 12:53:29 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20051107125329.E1671@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Fix STx GP3 build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add missing include file to fix STx GP3 build.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/platforms/85xx/stx_gp3.h b/arch/ppc/platforms/85xx/stx_gp3.h
index 95fdf4b..7bcc6c3 100644
--- a/arch/ppc/platforms/85xx/stx_gp3.h
+++ b/arch/ppc/platforms/85xx/stx_gp3.h
@@ -21,6 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/seq_file.h>
 #include <asm/ppcboot.h>
 
 #define BOARD_CCSRBAR		((uint)0xe0000000)
