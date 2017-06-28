Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyDlr49FCzDr3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:23:04 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S7J23A041800
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 03:23:02 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bbwtxvm1c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 03:23:01 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 28 Jun 2017 17:22:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5S7MtYe61669576
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:22:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5S7MslK027489
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 17:22:55 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: fbarrat@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: [PATCH] MAINTAINERS: cxl: update maintainership
Date: Wed, 28 Jun 2017 17:22:30 +1000
Message-Id: <20170628072230.7204-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Ian's stepping down from his maintainer role now that he's leaving IBM,
Frederic has asked me to add myself to the cxl maintainer list. Updating
accordingly.

Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Applies on top of http://patchwork.ozlabs.org/patch/781464
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6547fc1b5299..b1fd5a02dd28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3722,6 +3722,7 @@ F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
 CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
 M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
+M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/pci-cxl.c
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
