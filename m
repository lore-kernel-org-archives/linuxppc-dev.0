Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 464CC2C0370
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 16:54:08 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 11:24:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 75A243940060
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G5ugbQ46661806
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:26:42 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G5rx25002200
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:59 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] power7,
 perf: Make some new raw event codes available in sysfs
Date: Wed, 16 Oct 2013 11:22:59 +0530
Message-Id: <1381902780-2719-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds some more raw event codes into the existing list
of event codes present in power7-events-list.h file. This tries
to complete the list of events supported in Power7 and matches
the raw event list with libpfm4 library.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power7-events-list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/perf/power7-events-list.h b/arch/powerpc/perf/power7-events-list.h
index 687790a..64f13d9 100644
--- a/arch/powerpc/perf/power7-events-list.h
+++ b/arch/powerpc/perf/power7-events-list.h
@@ -546,3 +546,13 @@ EVENT(PM_MRK_DATA_FROM_RL2L3_SHR,             0x1d04c)
 EVENT(PM_DTLB_MISS_16M,                       0x4c05e)
 EVENT(PM_LSU1_LMQ_LHR_MERGE,                  0x0d09a)
 EVENT(PM_IFU_FIN,                             0x40066)
+EVENT(PM_1THRD_CON_RUN_INSTR,                 0x30062)
+EVENT(PM_CMPLU_STALL_COUNT,                   0x4000B)
+EVENT(PM_MEM0_PB_RD_CL,                       0x30083)
+EVENT(PM_THRD_1_RUN_CYC,                      0x10060)
+EVENT(PM_THRD_2_CONC_RUN_INSTR,               0x40062)
+EVENT(PM_THRD_2_RUN_CYC,                      0x20060)
+EVENT(PM_THRD_3_CONC_RUN_INST,                0x10062)
+EVENT(PM_THRD_3_RUN_CYC,                      0x30060)
+EVENT(PM_THRD_4_CONC_RUN_INST,                0x20062)
+EVENT(PM_THRD_4_RUN_CYC,                      0x40060)
-- 
1.7.11.7
