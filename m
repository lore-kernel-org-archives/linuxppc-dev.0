Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40192t45q9zF13J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 09:46:56 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DMeLre118270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 18:46:53 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gpnmyv8dj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 18:46:52 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 16:46:52 -0600
Date: Tue, 13 Mar 2018 15:46:47 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull JSON files for POWR9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20180313224647.GA22960@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Arnaldo,

Please pull an update to the JSON files for POWER9 PMU events.

The following changes since commit 90d2614c4d10c2f9d0ada9a3b01e5f43ca8d1ae3:

  perf test: Fix exit code for record+probe_libc_inet_pton.sh (2018-03-13 15:14:43 -0300)

are available in the git repository at:

  https://github.com/sukadev/linux/ p9-json-v5

for you to fetch changes up to 99c9dff949f2502964005f9afa8d60c89b446f2c:

  perf vendor events: Update POWER9 events (2018-03-13 16:48:12 -0500)

----------------------------------------------------------------
Sukadev Bhattiprolu (1):
      perf vendor events: Update POWER9 events

 .../perf/pmu-events/arch/powerpc/power9/cache.json |  25 ---
 .../pmu-events/arch/powerpc/power9/frontend.json   |  10 -
 .../pmu-events/arch/powerpc/power9/marked.json     |   5 -
 .../pmu-events/arch/powerpc/power9/memory.json     |   5 -
 .../perf/pmu-events/arch/powerpc/power9/other.json | 241 ++++++++++++++-------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  50 ++---
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   5 -
 .../arch/powerpc/power9/translation.json           |  10 +-
 8 files changed, 178 insertions(+), 173 deletions(-)
