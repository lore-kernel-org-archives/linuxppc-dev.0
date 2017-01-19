Return-Path: <groug@kaod.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v40ws1YrRzDqLw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 21:50:20 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0JAmg7d088003
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 05:50:18 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2829n334g5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 05:50:18 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <groug@kaod.org>;
 Thu, 19 Jan 2017 03:50:16 -0700
Subject: [PATCH] cxl: drop unused header asm/pnv-pci.h
From: Greg Kurz <groug@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Date: Thu, 19 Jan 2017 11:50:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148482301037.30441.14177888563610790803.stgit@bahia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kernel API does not use anything from this header file.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 drivers/misc/cxl/api.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 1b35e33d2434..bcc030eacab7 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <misc/cxl.h>
-#include <asm/pnv-pci.h>
 #include <linux/msi.h>
 #include <linux/module.h>
 #include <linux/mount.h>
