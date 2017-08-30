Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjLvQ6SLjzDqR9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 09:15:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7UNDfWc071119
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:15:12 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cp2emwth7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 19:15:12 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 30 Aug 2017 17:15:11 -0600
Date: Wed, 30 Aug 2017 16:15:06 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 mpetlan@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull JSON files for POWER9 PMU events
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20170830231506.GB20351@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Arnaldo,

Please pull an update to the JSON files for POWER9 PMU events. This
removes alternate event codes from the JSON files which seem to confuse
perf.

The following changes since commit 1b2f76d77a277bb70d38ad0991ed7f16bbc115a9:

  Merge tag 'perf-core-for-mingo-4.14-20170829' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-29 23:13:56 +0200)

are available in the git repository at:

  https://github.com/sukadev/linux/ p9-json-v3

Sukadev Bhattiprolu (1):
      perf vendor events powerpc: remove duplicate events

 .../pmu-events/arch/powerpc/power9/frontend.json   |    7 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |  120 --------------------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |    7 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |    7 +-
 4 files changed, 3 insertions(+), 138 deletions(-)
