Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A33E41A1DD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 13:20:53 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 644661402A9
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2015 13:20:52 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so45094231pab.0
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 20:20:50 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/4] cxl: Compile with -Werror
Date: Fri,  7 Aug 2015 13:18:17 +1000
Message-Id: <1438917500-12100-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's a good idea, and it brings us in line with the rest of arch/powerpc.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 14e3f8219a11..6f484dfe78f9 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,3 +1,5 @@
+ccflags-y := -Werror
+
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
 cxl-y				+= vphb.o api.o
-- 
2.1.4
