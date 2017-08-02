Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN0wy5vV9zDqqX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 03:46:26 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v72Hhjrm025395
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 13:46:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c3g8hhmg6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 13:46:24 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 2 Aug 2017 11:46:23 -0600
Date: Wed, 2 Aug 2017 10:46:17 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull JSON files for Power9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170802174617.GA32545@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Please pull some updates/cleanups to the POWER9 PMU events.

The following changes since commit 81e3d8b2af2e7417f1d5164aab5c1a75955e8a5d:

  perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg (2017-08-01 13:33:50 -0300)

are available in the git repository at:
  https://github.com/sukadev/linux/ p9-json-v2

Sukadev Bhattiprolu (2):
      perf vendor events powerpc: remove suffix in mapfile
      perf vendor events powerpc: Update POWER9 events

 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   20 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |  191 +-
 .../arch/powerpc/power9/floating-point.json        |   42 +-
 .../pmu-events/arch/powerpc/power9/frontend.json   |  517 ++---
 .../pmu-events/arch/powerpc/power9/marked.json     |  905 +++----
 .../pmu-events/arch/powerpc/power9/memory.json     |  178 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 2716 ++++++++++++++++----
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  779 +++----
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |  167 +-
 .../arch/powerpc/power9/translation.json           |  314 +--
 10 files changed, 3521 insertions(+), 2308 deletions(-)
