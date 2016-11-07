Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBvt83yvgzDvMr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 12:26:40 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA71NhCq044994
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 20:26:37 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26j8nmnyx4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 20:26:37 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 06:56:34 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 016CC1258026
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 06:57:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA71Q7GT17432584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:07 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA71QUNV000417
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 06:56:31 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 0/4]Support PowerISA v3.0 PMU Raw event format
Date: Mon,  7 Nov 2016 06:56:15 +0530
Message-Id: <1478481979-26224-1-git-send-email-maddy@linux.vnet.ibm.com>
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

Madhavan Srinivasan (4):
  powerpc/perf: factor out the event format field
  powerpc/perf: update attribute_group data structure
  powerpc/perf: PowerISA v3.0 raw event format encoding
  powerpc/perf: macros for PowerISA v3.0 format encoding

 arch/powerpc/perf/isa207-common.c | 122 ++++++++++++++++++++++++++++++++++++--
 arch/powerpc/perf/isa207-common.h |  27 ++++++++-
 arch/powerpc/perf/power8-pmu.c    |  39 ++----------
 arch/powerpc/perf/power9-pmu.c    | 112 +++++++++++++++++++++++++++++++++-
 4 files changed, 255 insertions(+), 45 deletions(-)

-- 
2.7.4
