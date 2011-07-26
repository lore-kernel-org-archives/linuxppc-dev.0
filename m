Return-Path: <B21989@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF448B70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 16:44:48 +1000 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx: fix memory controller compatible for edac
Date: Tue, 26 Jul 2011 13:46:33 +0800
Message-ID: <1311659193-694-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mm-commits@vger.kernel.org, Shaohui Xie <Shaohui.Xie@freescale.com>,
	kumar.gala@freescale.com, avorontsov@mvista.com,
	akpm@linux-foundation.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

compatible in dts has been changed, so driver need to update accordingly.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
apply for http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
'next' branch.

 drivers/edac/mpc85xx_edac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 13f6cc5..94c064a 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -1253,7 +1253,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,p1020-memory-controller", },
 	{ .compatible = "fsl,p1021-memory-controller", },
 	{ .compatible = "fsl,p2020-memory-controller", },
-	{ .compatible = "fsl,p4080-memory-controller", },
+	{ .compatible = "fsl,qoriq-memory-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
-- 
1.6.4
