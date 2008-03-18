Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 05053DE17F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:44:00 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 6C6F18814
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 20:44:17 +0400 (SAMT)
Date: Tue, 18 Mar 2008 18:43:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx: mpc837x_rdb: add simple-bus compatible
	matching
Message-ID: <20080318154359.GB31173@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed to probe nor and nand flashes on the localbus.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 9c498b7..a653a38 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -81,6 +81,7 @@ static void __init mpc837x_rdb_setup_arch(void)
 static struct of_device_id mpc837x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
-- 
1.5.2.2
