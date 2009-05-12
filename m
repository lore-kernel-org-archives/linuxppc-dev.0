Return-Path: <sankar.curiosity@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id C5854DDF7D
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 17:13:46 +1000 (EST)
Received: by bwz19 with SMTP id 19so3098623bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 00:13:43 -0700 (PDT)
Subject: [PATCH] Trivial spelling fix in ppc code comments
From: Sankar P <sankar.curiosity@gmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"trivial@kernel.org" <trivial@kernel.org>, linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 12 May 2009 12:41:13 +0530
Message-Id: <1242112273.736.6.camel@blr-psankar.blr.novell.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes a trivial spelling error in powerpc code comments. 

Signed-off-by: Sankar P <sankar.curiosity@gmail.com>

---
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 89497fb..3b52c80 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -2,7 +2,7 @@
  * PowerPC64 SLB support.
  *
  * Copyright (C) 2004 David Gibson <dwg@au.ibm.com>, IBM
- * Based on earlier code writteh by:
+ * Based on earlier code written by:
  * Dave Engebretsen and Mike Corrigan {engebret|mikejc}@us.ibm.com
  *    Copyright (c) 2001 Dave Engebretsen
  * Copyright (C) 2002 Anton Blanchard <anton@au.ibm.com>, IBM
