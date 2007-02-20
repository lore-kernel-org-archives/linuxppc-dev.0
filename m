Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 77DAFDDDCF
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 11:08:14 +1100 (EST)
Date: Tue, 20 Feb 2007 01:08:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [2.6 patch] unexport mac_hid_mouse_emulate_buttons
Message-ID: <20070220000812.GL13958@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch removes the unused
EXPORT_SYMBOL(mac_hid_mouse_emulate_buttons).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.20-mm2/drivers/macintosh/mac_hid.c.old	2007-02-19 15:37:13.000000000 +0100
+++ linux-2.6.20-mm2/drivers/macintosh/mac_hid.c	2007-02-19 15:37:22.000000000 +0100
@@ -102,8 +102,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(mac_hid_mouse_emulate_buttons);
-
 static int emumousebtn_input_register(void)
 {
 	int ret;
