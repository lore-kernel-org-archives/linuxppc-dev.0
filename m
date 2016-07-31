Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2XZg2thfzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:28:58 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6VJORe8089547
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:28:56 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24gpcusa17-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 15:28:56 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 05:28:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 98A323578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 05:28:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6VJSoWm28835866
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:28:50 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6VJSoHh026787
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 05:28:50 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: fix wrong event codes in power9-event-list
Date: Mon,  1 Aug 2016 00:58:39 +0530
Message-Id: <1469993319-29946-1-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/power9-events-list.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index cda6fcb809ca..6447dc1c3d89 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -34,15 +34,15 @@ EVENT(PM_L1_ICACHE_MISS,			0x200fd)
 /* Instruction Demand sectors wriittent into IL1 */
 EVENT(PM_L1_DEMAND_WRITE,			0x0408c)
 /* Instruction prefetch written into IL1 */
-EVENT(PM_IC_PREF_WRITE,				0x0408e)
+EVENT(PM_IC_PREF_WRITE,				0x0488c)
 /* The data cache was reloaded from local core's L3 due to a demand load */
 EVENT(PM_DATA_FROM_L3,				0x4c042)
 /* Demand LD - L3 Miss (not L2 hit and not L3 hit) */
 EVENT(PM_DATA_FROM_L3MISS,			0x300fe)
 /* All successful D-side store dispatches for this thread */
-EVENT(PM_L2_ST,					0x16081)
+EVENT(PM_L2_ST,					0x16880)
 /* All successful D-side store dispatches for this thread that were L2 Miss */
-EVENT(PM_L2_ST_MISS,				0x26081)
+EVENT(PM_L2_ST_MISS,				0x26880)
 /* Total HW L3 prefetches(Load+store) */
 EVENT(PM_L3_PREF_ALL,				0x4e052)
 /* Data PTEG reload */
-- 
2.7.4
