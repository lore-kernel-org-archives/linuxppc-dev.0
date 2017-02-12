Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4S60JYzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:36 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGwvxY136681
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:34 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28jsp7uj4w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:34 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:31 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2FCAC394004E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH3RHg29229194
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:27 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3RMP009409
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:27 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 2/6] powerpc/perf: Add PM_INST_DISP event to Power9 event
 list
Date: Sun, 12 Feb 2017 22:33:11 +0530
In-Reply-To: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1486918995-16354-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
Fix the event code.

 arch/powerpc/perf/power9-events-list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 929b56d47ad9..71a6bfee5c02 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -53,3 +53,6 @@ EVENT(PM_ITLB_MISS,				0x400fc)
 EVENT(PM_RUN_INST_CMPL,				0x500fa)
 /* Run_cycles */
 EVENT(PM_RUN_CYC,				0x600f4)
+/* Instruction Dispatched */
+EVENT(PM_INST_DISP,				0x200f2)
+EVENT(PM_INST_DISP_ALT,				0x300f2)
-- 
2.7.4
