Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6BCB2C00AB
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 16:23:14 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:46:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 291913940061
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M6N0qO7078290
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M6N687011747
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 06:23:08 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf: Introducing new conditional branch filter
Date: Wed, 22 May 2013 11:52:36 +0530
Message-Id: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, peterz@infradead.org,
 eranian@google.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset introduces conditional branch filter in perf branch stack
sampling framework incorporating review comments from Michael Neuling,
Peter Zijlstra and Stephane Eranian.

Anshuman Khandual (5):
  perf: New conditional branch filter criteria in branch stack sampling
  powerpc, perf: Enable conditional branch filter for POWER8
  perf, tool: Conditional branch filter 'cond' added to perf record
  x86, perf: Add conditional branch filtering support
  perf, documentation: Description for conditional branch filter

 arch/powerpc/perf/power8-pmu.c             | 10 ++++++++++
 arch/x86/kernel/cpu/perf_event_intel_lbr.c |  6 ++++++
 include/uapi/linux/perf_event.h            |  3 ++-
 tools/perf/Documentation/perf-record.txt   |  3 ++-
 tools/perf/builtin-record.c                |  1 +
 5 files changed, 21 insertions(+), 2 deletions(-)

-- 
1.7.11.7
