Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75EEDDDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:14:48 +1000 (EST)
Date: Tue, 28 Aug 2007 15:14:40 -0500
From: Scott Wood <scottwood@freescale.com>
To: jgarzik@pobox.com
Subject: [PATCH v3 3/8] fs_enet: Include linux/string.h from linux/fs_enet_pd.h
Message-ID: <20070828201440.GB24145@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
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
1.5.0.3
