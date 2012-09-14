Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6394B2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2012 03:13:25 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio: fix kerneldoc warnings after DMA support was added
Date: Fri, 14 Sep 2012 13:11:35 -0400
Message-Id: <1347642695-28549-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 "Robert P. J. Day" <rpjday@crashcourse.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Cc: Robert P. J. Day <rpjday@crashcourse.ca>
---
 include/linux/rio.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/rio.h b/include/linux/rio.h
index 1a7b6c7..ba382f2 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -236,6 +236,7 @@ enum rio_phy_type {
  * @phys_efptr: RIO port extended features pointer
  * @name: Port name string
  * @priv: Master port private data
+ * @dma: DMA device associated with mport
  */
 struct rio_mport {
 	struct list_head dbells;	/* list of doorbell events */
@@ -404,7 +405,7 @@ union rio_pw_msg {
 
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 
-/**
+/*
  * enum rio_write_type - RIO write transaction types used in DMA transfers
  *
  * Note: RapidIO specification defines write (NWRITE) and
-- 
1.7.8.4
