Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A65CE1A1151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:23:36 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 18/21] cxl: Cleanup Makefile
Date: Tue, 26 May 2015 10:20:15 +1000
Message-Id: <1432599618-26844-19-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleanup Makefile by fixing line wrapping.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index edb494d..f9f5514 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,5 @@
-cxl-y				+= main.o file.o irq.o fault.o native.o context.o sysfs.o debugfs.o pci.o trace.o
+cxl-y				+= main.o file.o irq.o fault.o native.o
+cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
 
-- 
2.1.0
