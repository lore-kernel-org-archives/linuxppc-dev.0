Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 43C6ADDF96
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 08:01:51 +1000 (EST)
Date: Thu, 20 Sep 2007 17:01:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH 2/9] fs_enet: Include linux/string.h from linux/fs_enet_pd.h
Message-ID: <20070920220117.GB28784@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070920220043.GA28769@loki.buserror.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It is needed for strstr().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 include/linux/fs_enet_pd.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 543cd3c..815c6f9 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -16,6 +16,7 @@
 #ifndef FS_ENET_PD_H
 #define FS_ENET_PD_H
 
+#include <linux/string.h>
 #include <asm/types.h>
 
 #define FS_ENET_NAME	"fs_enet"
-- 
1.5.3.1
