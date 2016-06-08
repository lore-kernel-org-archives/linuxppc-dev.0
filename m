Return-Path: <andreas.ziegler@fau.de>
Received: from faui40.informatik.uni-erlangen.de
 (faui40.informatik.uni-erlangen.de [131.188.34.40])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPkFP2x4KzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 19:50:17 +1000 (AEST)
From: Andreas Ziegler <andreas.ziegler@fau.de>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Valentin Rothberg <valentinrothberg@gmail.com>,
 linux-kernel@vger.kernel.org, Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH] drivers/net/fsl_ucc: Do not prefix header guard with CONFIG_
Date: Wed,  8 Jun 2016 11:40:28 +0200
Message-Id: <1465378828-7077-1-git-send-email-andreas.ziegler@fau.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CONFIG_ prefix should only be used for options which
can be configured through Kconfig and not for guarding headers.

Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 drivers/net/wan/fsl_ucc_hdlc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.h b/drivers/net/wan/fsl_ucc_hdlc.h
index 525786a..881ecde 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.h
+++ b/drivers/net/wan/fsl_ucc_hdlc.h
@@ -8,8 +8,8 @@
  * option) any later version.
  */
 
-#ifndef CONFIG_UCC_HDLC_H
-#define CONFIG_UCC_HDLC_H
+#ifndef _UCC_HDLC_H_
+#define _UCC_HDLC_H_
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-- 
1.9.1
