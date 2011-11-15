Return-Path: <akpm@linux-foundation.org>
Received: from mail-gx0-f202.google.com (mail-gx0-f202.google.com
 [209.85.161.202]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 53936B6F95
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Nov 2011 09:52:31 +1100 (EST)
Received: by ggnp4 with SMTP id p4so301098ggn.3
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Nov 2011 14:52:28 -0800 (PST)
Message-Id: <201111152252.pAFMqMYB032421@wpaz1.hot.corp.google.com>
Subject: [patch 1/1] drivers/edac/mpc85xx_edac.c: fix memory controller
 compatible for edac
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Tue, 15 Nov 2011 14:52:22 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
 Shaohui.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: drivers/edac/mpc85xx_edac.c: fix memory controller compatible for edac

compatible in dts has been changed, so the driver needs to be updated
accordingly.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/edac/mpc85xx_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/edac/mpc85xx_edac.c~drivers-edac-mpc85xx_edacc-fix-memory-controller-compatible-for-edac drivers/edac/mpc85xx_edac.c
--- a/drivers/edac/mpc85xx_edac.c~drivers-edac-mpc85xx_edacc-fix-memory-controller-compatible-for-edac
+++ a/drivers/edac/mpc85xx_edac.c
@@ -1128,7 +1128,7 @@ static struct of_device_id mpc85xx_mc_er
 	{ .compatible = "fsl,p1020-memory-controller", },
 	{ .compatible = "fsl,p1021-memory-controller", },
 	{ .compatible = "fsl,p2020-memory-controller", },
-	{ .compatible = "fsl,p4080-memory-controller", },
+	{ .compatible = "fsl,qoriq-memory-controller", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
_
