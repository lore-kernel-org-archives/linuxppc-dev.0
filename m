Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 45D6FDE430
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 17:10:26 +1000 (EST)
Date: Thu, 21 Aug 2008 00:10:25 -0700 (PDT)
Message-Id: <20080821.001025.76289480.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3]: of: Add some I2C mod aliases table entries for
	sparc64 systems.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sparclinux@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


of: Add some I2C mod aliases table entries for sparc64 systems.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/of/base.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..e849f69 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -410,7 +410,9 @@ struct of_modalias_table {
 	char *modalias;
 };
 static struct of_modalias_table of_modalias_table[] = {
-	/* Empty for now; add entries as needed */
+	{ "i2c-adm1031", "adm1031" },
+	{ "i2c-at24c64", "24c64" },
+	{ "i2c-at34c02", "spd" },
 };
 
 /**
-- 
1.5.6.5.GIT
