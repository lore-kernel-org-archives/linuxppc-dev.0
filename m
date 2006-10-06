Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D838367EB7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 13:54:34 +1000 (EST)
Date: Fri, 6 Oct 2006 13:54:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] fix viocons for irq breakage
Message-Id: <20061006135428.6f67cd98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viocons.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/viocons.c b/drivers/char/viocons.c
index a362ee9..6d2e314 100644
--- a/drivers/char/viocons.c
+++ b/drivers/char/viocons.c
@@ -947,7 +947,7 @@ #ifdef CONFIG_MAGIC_SYSRQ
 				 */
 				continue;
 			} else if (vio_sysrq_pressed) {
-				handle_sysrq(cevent->data[index], NULL, tty);
+				handle_sysrq(cevent->data[index], tty);
 				vio_sysrq_pressed = 0;
 				/*
 				 * continue because we don't want to add
-- 
1.4.2.1
