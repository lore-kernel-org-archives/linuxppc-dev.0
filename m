Return-Path: <aik@ozlabs.ru>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C961E2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 17:41:27 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 21 Nov 2013 16:41:26 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D80012BB0053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 17:41:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAL6NSM47471490
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 17:23:28 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAL6fG2C009252
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 17:41:16 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] iommu: Add empty stub for iommu_group_get_by_id()
Date: Thu, 21 Nov 2013 17:41:14 +1100
Message-Id: <1385016074-17026-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Almost every function in include/linux/iommu.h has an empty stub
but the iommu_group_get_by_id() did not get one by mistake.

This adds an empty stub for iommu_group_get_by_id() for IOMMU_API
disabled config.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/linux/iommu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ea319e..3c7903d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -245,6 +245,11 @@ static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 	return NULL;
 }
 
+static inline struct iommu_group *iommu_group_get_by_id(int id)
+{
+	return NULL;
+}
+
 static inline void iommu_domain_free(struct iommu_domain *domain)
 {
 }
-- 
1.8.4.rc4
