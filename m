Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywC1x5fQQzDqmW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 16:58:45 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBB5uO7i029447
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:43 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eshw2yekw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 00:58:43 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 11 Dec 2017 05:58:41 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com
Subject: [PATCH 0/3] IMC code clean up and refactoring
Date: Mon, 11 Dec 2017 11:28:34 +0530
Message-Id: <1512971917-23851-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first patch removes the unused variable in the code for 
IMC(In-memory collection counters).

The second patch does some code refactoring.

The third patch in the series make struct imc_events as a parameter to the
function imc_parse_event().

Anju T Sudhakar (3):
  powerpc/perf: Remove thread_imc_pmu global variable from
	imc code
  powerpc/perf: IMC code cleanup with some code refactoring
  powerpc/perf: Passs struct imc_events as a parameter to
    imc_parse_event()

 arch/powerpc/include/asm/imc-pmu.h |  2 +-
 arch/powerpc/perf/imc-pmu.c        | 99 +++++++++++++++++++++++---------------
 2 files changed, 61 insertions(+), 40 deletions(-)

-- 
2.7.4
