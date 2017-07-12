Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6j6Y61b6zDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 12:08:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C2430Z004194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:08:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0mvdavs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:08:33 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 22:08:32 -0400
Date: Tue, 11 Jul 2017 19:08:27 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.orgi>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull JSON files for Power9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170712020827.GB31223@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Please pull the JSON files for POWER9 PMU events.

The following changes since commit 07d306c838c5c30196619baae36107d0615e459b:

  Merge git://www.linux-watchdog.org/linux-watchdog (2017-07-11 09:59:37 -0700)

are available in the git repository at:

  https://github.com/sukadev/linux/ p9-json

for you to fetch changes up to f94a86dbb13e18bd7ad566cabe42df63d3bd1039:

  perf vendor events: Add POWER9 PVRs to mapfile (2017-07-11 19:30:40 -0500)

----------------------------------------------------------------
Sukadev Bhattiprolu (2):
      perf vendor events: Add POWER9 PMU events
      perf vendor events: Add POWER9 PVRs to mapfile

 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   2 +
 .../perf/pmu-events/arch/powerpc/power9/cache.json | 176 +++++
 .../arch/powerpc/power9/floating-point.json        |  44 ++
 .../pmu-events/arch/powerpc/power9/frontend.json   | 446 +++++++++++
 .../pmu-events/arch/powerpc/power9/marked.json     | 782 +++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/memory.json     | 158 ++++
 .../perf/pmu-events/arch/powerpc/power9/other.json | 836 +++++++++++++++++++++
 .../pmu-events/arch/powerpc/power9/pipeline.json   | 680 +++++++++++++++++
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json | 146 ++++
 .../arch/powerpc/power9/translation.json           | 272 +++++++
 10 files changed, 3542 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/cache.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/marked.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/memory.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/other.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/pmc.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/translation.json
