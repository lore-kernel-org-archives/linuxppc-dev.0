Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbBcw4lmHzDsd5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:16 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8GAbcx9063037
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:14 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ftr8ew6q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 06:40:13 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 16 Sep 2016 20:40:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 60BB22CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8GAe9iP66977898
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8GAe80Z027529
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 20:40:09 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, benh@kernel.crashing.org,
 gwshan@linux.vnet.ibm.com
Subject: [RFC 1/3] powerpc/powernv: fix comment style and spelling
Date: Fri, 16 Sep 2016 20:39:44 +1000
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
In-Reply-To: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
References: <cover.303079d6fcc8cba76e4648314eee9a30def3d969.1474022276.git-series.andrew.donnellan@au1.ibm.com>
Message-Id: <cc1572ad40f65b3ea614ae840e23083ce1a65def.1474022276.git-series.andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c16d790..ca5e9b5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3736,10 +3736,11 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
 
-	/* If we're running in kdump kerenl, the previous kerenl never
+	/*
+	 * If we're running in kdump kernel, the previous kernel never
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
-	 * transactions from previous kerenl.
+	 * transactions from previous kernel.
 	 */
 	if (is_kdump_kernel()) {
 		pr_info("  Issue PHB reset ...\n");
-- 
git-series 0.8.10
