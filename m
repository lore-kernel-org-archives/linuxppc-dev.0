Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBpWJ3463zDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:25:16 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UCP1Dp051560
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:14 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28a3d3dq56-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 07:25:11 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 22:24:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 388C1357805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:44 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UCOaGo35586284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:44 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UCOBLe007277
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 23:24:12 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powerpc/perf: Add PM_INST_DISP event to Power9 event list
Date: Mon, 30 Jan 2017 17:53:38 +0530
In-Reply-To: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1485779021-31936-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1485779021-31936-2-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/power9-events-list.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 929b56d47ad9..8210b0d5bcd1 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -53,3 +53,6 @@ EVENT(PM_ITLB_MISS,				0x400fc)
 EVENT(PM_RUN_INST_CMPL,				0x500fa)
 /* Run_cycles */
 EVENT(PM_RUN_CYC,				0x600f4)
+/* Instruction Dispatched */
+EVENT(PM_INST_DISP,				0x200f0)
+EVENT(PM_INST_DISP_ALT,				0x300f0)
-- 
2.7.4
