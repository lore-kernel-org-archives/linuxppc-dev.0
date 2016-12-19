Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thwS75fD7zDwKH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:22:47 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <scott.wood@nxp.com>, <mpe@ellerman.id.au>
Subject: [PATCH net v2 2/5] powerpc: remove fsl,fman from of_device_ids[]
Date: Mon, 19 Dec 2016 11:22:20 +0200
Message-ID: <1482139343-8975-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1482139343-8975-1-git-send-email-madalin.bucur@nxp.com>
References: <1482139343-8975-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The fsl/fman drivers will use of_platform_populate() on all
supported platforms.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1179115..824b7f1 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -117,9 +117,6 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qe",
 	},
-	{
-		.compatible    = "fsl,fman",
-	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
-- 
2.1.0
