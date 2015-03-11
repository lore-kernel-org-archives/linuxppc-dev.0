Return-Path: <maddy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D1CB1A0AAA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:08:44 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 149EF140157
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 23:08:43 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7FE712CE8057
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD8WZJ52166798
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:40 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD85qU011911
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2015 00:08:07 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 7/7]powerpc/powernv: enable nest pmu related file in
 Makefile
Date: Wed, 11 Mar 2015 18:37:13 +0530
Message-Id: <1426079233-16720-8-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch to enable the nest pmu code files in Makefile.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index f9c083a..4b0bfd8 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= callchain.o
 obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
-				   power8-pmu.o
+				   power8-pmu.o uncore_pmu.o uncore_pmu_p8.o
 obj32-$(CONFIG_PPC_PERF_CTRS)	+= mpc7450-pmu.o
 
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
-- 
1.9.1
