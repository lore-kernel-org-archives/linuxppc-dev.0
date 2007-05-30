Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 00E28DDF78
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 11:29:08 +1000 (EST)
Date: Wed, 30 May 2007 11:29:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] VIOTAPE:  Use designated initializers for fops member
	structures.
Message-Id: <20070530112906.9d5b6fb3.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0705281702300.16015@localhost.localdomain>
References: <Pine.LNX.4.64.0705281702300.16015@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Robert P. J. Day <rpjday@mindspring.com>

Replace the old-style member initializers with the newer designated
initializers.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viotape.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Paul, one for 2.6.23.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 13faf8d..db57277 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -873,12 +873,12 @@ free_op:
 }
 
 const struct file_operations viotap_fops = {
-	owner: THIS_MODULE,
-	read: viotap_read,
-	write: viotap_write,
-	ioctl: viotap_ioctl,
-	open: viotap_open,
-	release: viotap_release,
+	.owner =	THIS_MODULE,
+	.read =		viotap_read,
+	.write =	viotap_write,
+	.ioctl =	viotap_ioctl,
+	.open =		viotap_open,
+	.release =	viotap_release,
 };
 
 /* Handle interrupt events for tape */
-- 
1.5.1.4
