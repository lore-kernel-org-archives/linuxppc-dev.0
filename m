Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com
 [IPv6:2a00:1450:4010:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 714F41400D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 00:16:17 +1000 (EST)
Received: by mail-la0-f44.google.com with SMTP id hr17so856721lab.31
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 07:16:12 -0700 (PDT)
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Anatolij Gustschin <agust@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexander Popov <a13xp0p0v88@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 dmaengine@vger.kernel.org
Subject: [PATCH RFC v13 1/5] dmaengine: fix comment typo
Date: Thu, 15 May 2014 18:15:31 +0400
Message-Id: <1400163335-29853-2-git-send-email-a13xp0p0v88@gmail.com>
In-Reply-To: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
References: <1400163335-29853-1-git-send-email-a13xp0p0v88@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix comment typo.

Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
---
 include/linux/dmaengine.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8300fb8..cbb168e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -292,7 +292,7 @@ struct dma_chan_dev {
 };
 
 /**
- * enum dma_slave_buswidth - defines bus with of the DMA slave
+ * enum dma_slave_buswidth - defines bus width of the DMA slave
  * device, source or target buses
  */
 enum dma_slave_buswidth {
-- 
1.8.4.2
