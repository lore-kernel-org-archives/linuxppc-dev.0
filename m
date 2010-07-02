Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B328D100929
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 22:41:18 +1000 (EST)
Date: Fri, 2 Jul 2010 16:41:17 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] edac: mpc85xx: Add support for MPC8569 EDAC controllers
Message-ID: <20100702124117.GB23320@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simply add a proper ID into the device table.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/edac/mpc85xx_edac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 52ca09b..f39b00a 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -1120,6 +1120,7 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
 	{ .compatible = "fsl,mpc8555-memory-controller", },
 	{ .compatible = "fsl,mpc8560-memory-controller", },
 	{ .compatible = "fsl,mpc8568-memory-controller", },
+	{ .compatible = "fsl,mpc8569-memory-controller", },
 	{ .compatible = "fsl,mpc8572-memory-controller", },
 	{ .compatible = "fsl,mpc8349-memory-controller", },
 	{ .compatible = "fsl,p2020-memory-controller", },
-- 
1.7.0.5
