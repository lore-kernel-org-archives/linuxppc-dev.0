Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B3DB6DDE3A
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:26:49 +1000 (EST)
Date: Sun, 22 Jul 2007 00:27:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] constify of_platform_driver match_table
Message-Id: <20070722002701.77622474.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>, wli@holomorphy.com,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/of_platform.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig and Sparc and Sparc64
defconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 22c3837..448f70b 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -32,7 +32,7 @@ extern struct bus_type of_platform_bus_type;
 struct of_platform_driver
 {
 	const char		*name;
-	struct of_device_id	*match_table;
+	const struct of_device_id	*match_table;
 	struct module		*owner;
 
 	int	(*probe)(struct of_device* dev,
-- 
1.5.2.3
