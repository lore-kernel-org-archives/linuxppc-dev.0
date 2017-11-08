Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXHhg4TRhzDrCr
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 07:19:46 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA8KIkpK118885
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Nov 2017 15:19:44 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e48ts03md-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Nov 2017 15:19:43 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 8 Nov 2017 13:19:43 -0700
Date: Wed, 8 Nov 2017 12:19:38 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull JSON files for POWR9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20171108201938.GA10985@us.ibm.com>
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

The following changes since commit 148b43a3540bf25875bb5ab695a446950dc8d559:

  tools headers: Synchronize kernel ABI headers wrt SPDX tags (2017-11-07 13:41:35 -0300)

are available in the git repository at:

  https://github.com/sukadev/linux p9-json-v4

for you to fetch changes up to 4afb062d7d306bf56dbae9b5291e3515ccfede4c:

  perf vendor events powerpc: Update POWER9 events (2017-11-08 18:42:03 -0500)

----------------------------------------------------------------
Sukadev Bhattiprolu (1):
      perf vendor events powerpc: Update POWER9 events

 .../perf/pmu-events/arch/powerpc/power9/cache.json |   5 -
 .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
 .../pmu-events/arch/powerpc/power9/marked.json     |  27 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 276 ++++++---------------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  14 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   2 +-
 .../arch/powerpc/power9/translation.json           |   5 -
 7 files changed, 88 insertions(+), 248 deletions(-)
