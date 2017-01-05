Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvQZl5QFwzDq5r
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 22:34:55 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05BYYqe114590
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 06:34:53 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27sjbys5tm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 06:34:52 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 17:04:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E99371258060
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 17:06:15 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05BYlRR31719612
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 17:04:47 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05BYkev015094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 17:04:47 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/perf: Cleanup of PM_BR_CMPL vs. PM_BRU_CMPL in
 power9 event list
Date: Thu,  5 Jan 2017 17:04:34 +0530
In-Reply-To: <1483616075-11262-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483616075-11262-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1483616075-11262-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fixes:34922527a2bcb ('powerpc/perf: Add power9 event list macros for generic and cache events')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 6447dc1c3d89..c529d9e3e245 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,					0x0001e)
 EVENT(PM_ICT_NOSLOT_CYC,			0x100f8)
 EVENT(PM_CMPLU_STALL,				0x1e054)
 EVENT(PM_INST_CMPL,				0x00002)
-EVENT(PM_BRU_CMPL,				0x40060)
+EVENT(PM_BR_CMPL,				0x40060)
 EVENT(PM_BR_MPRED_CMPL,				0x400f6)
 
 /* All L1 D cache load references counted at finish, gated by reject */
-- 
2.7.4
