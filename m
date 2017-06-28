Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyCLx3zK8zDr3p
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 16:19:53 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5S6DgJu039594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:19:50 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bbwtxt60e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 02:19:50 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 28 Jun 2017 16:19:47 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5S6JiU14981166
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 16:19:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5S6Jhm0021385
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 16:19:44 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH] MAINTAINERS: Remove myself as cxl maintainer
Date: Wed, 28 Jun 2017 16:19:20 +1000
Message-Id: <20170628061920.26722-1-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

I am no longer employed by IBM and will no longer have access to cxl
hardware, so remove myself as a cxl maintainer.

If anyone needs to contact me in the future, please use my personal
email address darkstarsword@gmail.com

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e984645c4b0..1e8a915577fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3721,7 +3721,6 @@ S:	Supported
 F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
 CXL (IBM Coherent Accelerator Processor Interface CAPI) DRIVER
-M:	Ian Munsie <imunsie@au1.ibm.com>
 M:	Frederic Barrat <fbarrat@linux.vnet.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.11.0
