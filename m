Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id A419AB7BC3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 17:34:43 +1100 (EST)
Received: by gxk28 with SMTP id 28so699991gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 03 Nov 2009 22:34:42 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: Pierre Ossman <drzeus@drzeus.cx>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: fix missing module license declaration in of_mmc_spi.c
Date: Tue,  3 Nov 2009 23:34:04 -0700
Message-Id: <1257316444-7385-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Driver cannot be used as a module without this patch.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/host/of_mmc_spi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index fb2921f..644f67e 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -22,6 +22,8 @@
 #include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 
+MODULE_LICENSE("GPL");
+
 enum {
 	CD_GPIO = 0,
 	WP_GPIO,
-- 
1.6.3.3
