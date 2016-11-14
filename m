Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHdzM43S4zDvmj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 05:17:35 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEIDT23033863
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:17:33 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26qe4r68dp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 13:17:33 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 23:47:29 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7FBB5E005A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:47:37 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAEIHRlH25034782
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:47:27 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAEIHQdo009731
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:47:27 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] Support PowerISA v3.0 PMU Raw event format
Date: Mon, 14 Nov 2016 23:47:11 +0530
Message-Id: <1479147435-18665-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patchset to factor out the PowerISA v2.07 PMU raw event
format encoding and add support to the PowerISA v3.0 PMU
raw event format encoding.

Changelog v1:
1) Initialized "mmcra" variable to avoid compile time errors
2) Made changes to commit message

Madhavan Srinivasan (4):
  powerpc/perf: factor out the event format field
  powerpc/perf: update attribute_group data structure
  powerpc/perf: PowerISA v3.0 raw event format encoding
  powerpc/perf: macros for PowerISA v3.0 format encoding

 arch/powerpc/perf/isa207-common.c | 124 +++++++++++++++++++++++++++++++++++---
 arch/powerpc/perf/isa207-common.h |  27 ++++++++-
 arch/powerpc/perf/power8-pmu.c    |  39 ++----------
 arch/powerpc/perf/power9-pmu.c    | 112 +++++++++++++++++++++++++++++++++-
 4 files changed, 256 insertions(+), 46 deletions(-)

-- 
2.7.4
