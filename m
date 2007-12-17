Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id 3DB86DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 08:49:44 +1100 (EST)
Subject: Re: [PATCH] drivers/net/: Spelling fixes
From: Joe Perches <joe@perches.com>
To: Stefano Brivio <stefano.brivio@polimi.it>
In-Reply-To: <20071217215635.16fe17af@morte>
References: <1197920439-5455-2-git-send-email-joe@perches.com>
	<20071217215635.16fe17af@morte>
Content-Type: text/plain
Date: Mon, 17 Dec 2007 13:15:45 -0800
Message-Id: <1197926145.27386.56.camel@localhost>
Mime-Version: 1.0
Cc: Sivakumar Subramani <sivakumar.subramani@neterion.com>,
	netdev@vger.kernel.org, Ramkrishna Vepa <ram.vepa@neterion.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sreenivasa Honnur <sreenivasa.honnur@neterion.com>,
	Rastapur Santosh <santosh.rastapur@neterion.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-17 at 21:56 +0100, Stefano Brivio wrote:
> On Mon, 17 Dec 2007 11:40:08 -0800
> Joe Perches <joe@perches.com> wrote:
> > diff --git a/drivers/net/ucc_geth_ethtool.c
> b/drivers/net/ucc_geth_ethtool.c
> > index 9a9622c..f8d319b 100644
> > --- a/drivers/net/ucc_geth_ethtool.c
> > +++ b/drivers/net/ucc_geth_ethtool.c
> > @@ -7,7 +7,7 @@
> >   *
> >   * Limitation: 
> >   * Can only get/set setttings of the first queue.
>                          ^^^

Good eyes...  Unrelated to what I changed too.
cheers, Joe

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/drivers/net/s2io.c b/drivers/net/s2io.c
index 121cb10..cdfb2b0 100644
--- a/drivers/net/s2io.c
+++ b/drivers/net/s2io.c
@@ -6823,8 +6823,8 @@ static void do_s2io_card_down(struct s2io_nic * sp, int do_io)
 	while(do_io) {
 		/* As per the HW requirement we need to replenish the
 		 * receive buffer to avoid the ring bump. Since there is
-		 * no intention of processing the Rx frame at this pointwe are
-		 * just settting the ownership bit of rxd in Each Rx
+		 * no intention of processing the Rx frame at this point we are
+		 * just setting the ownership bit of rxd in each Rx
 		 * ring to HW and set the appropriate buffer size
 		 * based on the ring mode
 		 */
diff --git a/drivers/net/ucc_geth_ethtool.c b/drivers/net/ucc_geth_ethtool.c
index f8d319b..3e50df8 100644
--- a/drivers/net/ucc_geth_ethtool.c
+++ b/drivers/net/ucc_geth_ethtool.c
@@ -6,7 +6,7 @@
  * Author: Li Yang <leoli@freescale.com>
  *
  * Limitation: 
- * Can only get/set setttings of the first queue.
+ * Can only get/set settings of the first queue.
  * Need to re-open the interface manually after changing some parameters.
  *
  * This program is free software; you can redistribute  it and/or modify it
