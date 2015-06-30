Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC7831A100F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 18:20:39 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E2CD1402CC
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 18:20:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 30 Jun 2015 13:50:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 103AB394005A
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:34 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5U8KXvZ66650120
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 13:50:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5U7DMVA029608
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2015 12:43:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net,
 mpe@ellerman.id.au
Subject: [PATCH 0/5] BHRB fixes, improvements and cleanups
Date: Tue, 30 Jun 2015 13:50:26 +0530
Message-Id: <1435652431-22024-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	The five generic patches from BHRB SW branch filter enablement
series have been separated and grouped together in this series. These
patches are required to be applied before using the upcoming V10 of the
BHRB SW branch filter patch series.

Anshuman Khandual (5):
  powerpc/perf: Drop the branch sample when 'from' cannot be fetched
  powerpc/perf: Change type of the bhrb_users variable
  powerpc/perf: Replace last usage of get_cpu_var with this_cpu_ptr
  powerpc/perf: Change name & type of 'pred' in power_pmu_bhrb_read
  powerpc/perf: Re organize PMU branch filter processing on POWER8

 arch/powerpc/perf/core-book3s.c | 29 +++++++++++++++--------------
 arch/powerpc/perf/power8-pmu.c  | 22 +++++++---------------
 2 files changed, 22 insertions(+), 29 deletions(-)

-- 
2.1.0
