Return-Path: <sparth1292@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjjt3kGNzF2F0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:20:46 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id k19-v6so3029480pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Aug 2018 03:20:46 -0700 (PDT)
From: Parth Y Shah <sparth1292@gmail.com>
To: fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Parth Y Shah <sparth1292@gmail.com>
Subject: [PATCH] misc: cxl: changed asterisk position
Date: Fri,  3 Aug 2018 15:50:38 +0530
Message-Id: <1533291638-22224-1-git-send-email-sparth1292@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resolved <"foo* bar" should be "foo *bar"> error

Signed-off-by: Parth Y Shah <sparth1292@gmail.com>
---
 drivers/misc/cxl/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 70dbb6d..d45f3e6 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -33,7 +33,7 @@ static bool sste_matches(struct cxl_sste *sste, struct copro_slb *slb)
  * This finds a free SSTE for the given SLB, or returns NULL if it's already in
  * the segment table.
  */
-static struct cxl_sste* find_free_sste(struct cxl_context *ctx,
+static struct cxl_sste *find_free_sste(struct cxl_context *ctx,
 				       struct copro_slb *slb)
 {
 	struct cxl_sste *primary, *sste, *ret = NULL;
-- 
2.7.4
