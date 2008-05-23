Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6E31CDDFF7
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:10 +1000 (EST)
Date: Fri, 23 May 2008 16:25:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: [PATCH 04/12] hwmon: use linux/of_platform.h instead of asm
Message-Id: <20080523162550.21eb90f2.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stelian Pop <stelian@popies.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/ams/ams-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ams/ams-core.c b/drivers/hwmon/ams/ams-core.c
index a112a03..fbefa82 100644
--- a/drivers/hwmon/ams/ams-core.c
+++ b/drivers/hwmon/ams/ams-core.c
@@ -23,8 +23,8 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/of_platform.h>
 #include <asm/pmac_pfunc.h>
-#include <asm/of_platform.h>
 
 #include "ams.h"
 
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
