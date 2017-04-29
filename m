Return-Path: <karim.eshapa@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFjMX3NpPzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 06:43:52 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id 6so10397703wrb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Apr 2017 13:43:52 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: oss@buserror.net
Cc: claudiu.manoil@nxp.com, roy.pledge@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] drivers:soc:fsl:qbman:qman.c: unsigned long jiffies value.
Date: Sat, 29 Apr 2017 22:43:40 +0200
Message-Id: <1493498620-9975-1-git-send-email-karim.eshapa@gmail.com>
In-Reply-To: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
References: <1493495164-8658-1-git-send-email-karim.eshapa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

unsigned long jiffies value sorry for that.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/soc/fsl/qbman/qman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index e0df4d1..6e1a44a 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1084,7 +1084,7 @@ static int drain_mr_fqrni(struct qm_portal *p)
 		 * entries well before the ring has been fully consumed, so
 		 * we're being *really* paranoid here.
 		 */
-		unsigned int udel_time = jiffies_to_usecs(10000);
+		unsigned long udel_time = jiffies_to_usecs(10000);
 
 		usleep_range(udel_time/2, udel_time);
 		msg = qm_mr_current(p);
-- 
2.7.4
