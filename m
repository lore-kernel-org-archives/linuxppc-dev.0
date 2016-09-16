Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb2NQ3dgWzDsZM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 14:28:54 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Subject: [PATCH] MAINTAINERS: Update cxl maintainers
Date: Fri, 16 Sep 2016 14:28:44 +1000
Message-Id: <1474000124-4646-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred has taken over the cxl maintenance I was doing.  This updates the
MAINTAINERS file to reflect this.

It also removes a duplicate entry in the files covered.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5e1270dfb..8d7a3d534b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3492,14 +3492,13 @@ F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
 CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
 M:	Ian Munsie <imunsie@au1.ibm.com>
-M:	Michael Neuling <mikey@neuling.org>
+M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	drivers/misc/cxl/
 F:	include/misc/cxl*
 F:	include/uapi/misc/cxl.h
 F:	Documentation/powerpc/cxl.txt
-F:	Documentation/powerpc/cxl.txt
 F:	Documentation/ABI/testing/sysfs-class-cxl
 
 CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
-- 
2.7.4
