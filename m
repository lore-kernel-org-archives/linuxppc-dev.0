Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id A540CDDEEF
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 05:09:09 +1000 (EST)
Date: Sat, 2 Jun 2007 21:09:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Subject: [2.6 patch] make drivers/char/hvc_console.c:khvcd() static
Message-ID: <20070602190911.GL5500@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the needlesly global khvcd() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---
--- linux-2.6.22-rc3-mm1/drivers/char/hvc_console.c.old	2007-06-02 19:58:07.000000000 +0200
+++ linux-2.6.22-rc3-mm1/drivers/char/hvc_console.c	2007-06-02 19:58:28.000000000 +0200
@@ -674,7 +674,7 @@
  * calling hvc_poll() who determines whether a console adapter support
  * interrupts.
  */
-int khvcd(void *unused)
+static int khvcd(void *unused)
 {
 	int poll_mask;
 	struct hvc_struct *hp;
