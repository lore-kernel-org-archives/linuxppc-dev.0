Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 931DBDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:58:50 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] xsysace: add compatible string
Date: Thu, 27 Nov 2008 18:49:58 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811271849.58535.yur@emcraft.com>
Cc: Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add one more compatible string to the table for
of_platform binding, so that the platforms, which
have the SysACE chip on board (e.g. Katmai), could
describe it in their device trees correctly.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
---
 drivers/block/xsysace.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 29e1dfa..381d686 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1206,6 +1206,7 @@ static struct of_device_id ace_of_match[] __devinitdata = {
 	{ .compatible = "xlnx,opb-sysace-1.00.b", },
 	{ .compatible = "xlnx,opb-sysace-1.00.c", },
 	{ .compatible = "xlnx,xps-sysace-1.00.a", },
+	{ .compatible = "xlnx,sysace", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ace_of_match);
-- 
1.5.6.1
