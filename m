Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9BsR52cxzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 22:35:39 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty/hvc: fix spelling mistake: "missmanaged" ->
 "mismanaged"
Date: Sat, 22 Apr 2017 13:35:33 +0100
Message-Id: <20170422123533.8567-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in printk message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/hvc/hvcs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 7823d6d998cf..2113c64d565d 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1242,8 +1242,7 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		free_irq(irq, hvcsd);
 		return;
 	} else if (hvcsd->port.count < 0) {
-		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d"
-				" is missmanaged.\n",
+		printk(KERN_ERR "HVCS: vty-server@%X open_count: %d is mismanaged.\n",
 		hvcsd->vdev->unit_address, hvcsd->port.count);
 	}
 
-- 
2.11.0
