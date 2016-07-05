Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkByZ6sy2zDrQB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:19:34 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u655JUiG123296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 01:19:33 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23xa4csygn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 01:19:32 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 5 Jul 2016 15:19:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 21C692CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:19:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u655JPFk60096644
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 15:19:26 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u655JPg9016614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 15:19:25 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: david@gibson.dropbear.id.au
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] Add KVM_CAP_PPC_HTM to linux/kvm.h
Date: Tue,  5 Jul 2016 15:19:23 +1000
In-Reply-To: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
References: <20160608022602.GU9226@voom.fritz.box>
 <cover.1467695915.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
Message-Id: <d2e391d1e0e381276ee2bff8e59d872c4b3bd2b5.1467695915.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 linux-headers/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index e60e21b..37cb3e8 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -866,6 +866,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_ARM_PMU_V3 126
 #define KVM_CAP_VCPU_ATTRIBUTES 127
 #define KVM_CAP_MAX_VCPU_ID 128
+#define KVM_CAP_PPC_HTM 129
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.1.0
