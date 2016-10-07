Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3srJ261594zDrTy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Oct 2016 05:29:01 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u97IPpnl134039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Oct 2016 14:29:00 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25xcb2c475-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Oct 2016 14:28:59 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 7 Oct 2016 12:28:59 -0600
Date: Fri, 7 Oct 2016 11:28:51 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Olsa <jolsa@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull JSON perf event lists
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20161007182851.GA3649@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

Please pull the JSON perf event lists for Powerpc and Intel CPUs.

The following changes since commit 1859e245e6ba91c0c46078622c5f0d6871b940f0:

  perf tools: Handle completion of upper case events (2016-10-06 17:00:04 -0300)

are available in the git repository at:
  git@github.com:sukadev/linux json-data-files-v22

Andi Kleen (19):
      perf jevents: Add BroadwellDE V5 event file
      perf jevents: Add Broadwell V17 event file
      perf jevents: Add BroadwellX V10 event file
      perf jevents: Add Bonnell V4 event file
      perf jevents: Add Goldmont V8 event file
      perf jevents: Add Haswell V24 event file
      perf jevents: Add HaswellX V17 event file
      perf jevents: Add IvyBridge V18 event file
      perf jevents: Add IvyTown V19 event file
      perf jevents: Add Jaketown V20 event file
      perf jevents: Add KnightsLanding V9 event file
      perf jevents: Add NehalemEP V2 event file
      perf jevents: Add NehalemEX V2 event file
      perf jevents: Add Skylake V24 event file
      perf jevents: Add Silvermont V13 event file
      perf jevents: Add SandyBridge V15 event file
      perf jevents: Add WestmereEP-DP V2 event file
      perf jevents: Add WestmereEP-SP V2 event file
      perf jevents: Add WestmereEX V2 event file

Madhavan Srinivasan (1):
      perf jevents: support couple more POWER8 PVRs in mapfile

Sukadev Bhattiprolu (1):
      perf jevents: Add power8 PMU events

 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   21 +
 .../perf/pmu-events/arch/powerpc/power8/Cache.json |  176 +
 .../arch/powerpc/power8/Floating-point.json        |   14 +
 .../pmu-events/arch/powerpc/power8/Frontend.json   |  470 +++
 .../pmu-events/arch/powerpc/power8/Marked.json     |  794 ++++
 .../pmu-events/arch/powerpc/power8/Memory.json     |  212 +
 .../perf/pmu-events/arch/powerpc/power8/Other.json | 4064 ++++++++++++++++++
 tools/perf/pmu-events/arch/powerpc/power8/PMC.json |  140 +
 .../pmu-events/arch/powerpc/power8/Pipeline.json   |  350 ++
 .../arch/powerpc/power8/Translation.json           |  176 +
 tools/perf/pmu-events/arch/x86/Bonnell/Cache.json  |  746 ++++
 .../arch/x86/Bonnell/Floating-point.json           |  261 ++
 .../perf/pmu-events/arch/x86/Bonnell/Frontend.json |   83 +
 tools/perf/pmu-events/arch/x86/Bonnell/Memory.json |  154 +
 tools/perf/pmu-events/arch/x86/Bonnell/Other.json  |  450 ++
 .../perf/pmu-events/arch/x86/Bonnell/Pipeline.json |  364 ++
 .../arch/x86/Bonnell/Virtual-Memory.json           |  124 +
 .../perf/pmu-events/arch/x86/Broadwell/Cache.json  | 3198 +++++++++++++++
 .../arch/x86/Broadwell/Floating-point.json         |  171 +
 .../pmu-events/arch/x86/Broadwell/Frontend.json    |  286 ++
 .../perf/pmu-events/arch/x86/Broadwell/Memory.json | 2845 +++++++++++++
 .../perf/pmu-events/arch/x86/Broadwell/Other.json  |   44 +
 .../pmu-events/arch/x86/Broadwell/Pipeline.json    | 1417 +++++++
 .../arch/x86/Broadwell/Virtual-Memory.json         |  388 ++
 .../pmu-events/arch/x86/BroadwellDE/Cache.json     |  774 ++++
 .../arch/x86/BroadwellDE/Floating-point.json       |  171 +
 .../pmu-events/arch/x86/BroadwellDE/Frontend.json  |  286 ++
 .../pmu-events/arch/x86/BroadwellDE/Memory.json    |  433 ++
 .../pmu-events/arch/x86/BroadwellDE/Other.json     |   44 +
 .../pmu-events/arch/x86/BroadwellDE/Pipeline.json  | 1417 +++++++
 .../arch/x86/BroadwellDE/Virtual-Memory.json       |  388 ++
 .../perf/pmu-events/arch/x86/BroadwellX/Cache.json |  942 +++++
 .../arch/x86/BroadwellX/Floating-point.json        |  171 +
 .../pmu-events/arch/x86/BroadwellX/Frontend.json   |  286 ++
 .../pmu-events/arch/x86/BroadwellX/Memory.json     |  649 +++
 .../perf/pmu-events/arch/x86/BroadwellX/Other.json |   44 +
 .../pmu-events/arch/x86/BroadwellX/Pipeline.json   | 1417 +++++++
 .../arch/x86/BroadwellX/Virtual-Memory.json        |  388 ++
 tools/perf/pmu-events/arch/x86/Goldmont/Cache.json | 1127 +++++
 .../pmu-events/arch/x86/Goldmont/Frontend.json     |   52 +
 .../perf/pmu-events/arch/x86/Goldmont/Memory.json  |   34 +
 tools/perf/pmu-events/arch/x86/Goldmont/Other.json |   52 +
 .../pmu-events/arch/x86/Goldmont/Pipeline.json     |  433 ++
 .../arch/x86/Goldmont/Virtual-Memory.json          |   75 +
 tools/perf/pmu-events/arch/x86/Haswell/Cache.json  | 1041 +++++
 .../arch/x86/Haswell/Floating-point.json           |   83 +
 .../perf/pmu-events/arch/x86/Haswell/Frontend.json |  294 ++
 tools/perf/pmu-events/arch/x86/Haswell/Memory.json |  655 +++
 tools/perf/pmu-events/arch/x86/Haswell/Other.json  |   43 +
 .../perf/pmu-events/arch/x86/Haswell/Pipeline.json | 1329 ++++++
 .../arch/x86/Haswell/Virtual-Memory.json           |  484 +++
 tools/perf/pmu-events/arch/x86/HaswellX/Cache.json | 1077 +++++
 .../arch/x86/HaswellX/Floating-point.json          |   83 +
 .../pmu-events/arch/x86/HaswellX/Frontend.json     |  294 ++
 .../perf/pmu-events/arch/x86/HaswellX/Memory.json  |  739 ++++
 tools/perf/pmu-events/arch/x86/HaswellX/Other.json |   43 +
 .../pmu-events/arch/x86/HaswellX/Pipeline.json     | 1329 ++++++
 .../arch/x86/HaswellX/Virtual-Memory.json          |  484 +++
 .../perf/pmu-events/arch/x86/IvyBridge/Cache.json  | 1123 +++++
 .../arch/x86/IvyBridge/Floating-point.json         |  151 +
 .../pmu-events/arch/x86/IvyBridge/Frontend.json    |  305 ++
 .../perf/pmu-events/arch/x86/IvyBridge/Memory.json |  236 ++
 .../perf/pmu-events/arch/x86/IvyBridge/Other.json  |   44 +
 .../pmu-events/arch/x86/IvyBridge/Pipeline.json    | 1307 ++++++
 .../arch/x86/IvyBridge/Virtual-Memory.json         |  180 +
 tools/perf/pmu-events/arch/x86/IvyTown/Cache.json  | 1272 ++++++
 .../arch/x86/IvyTown/Floating-point.json           |  151 +
 .../perf/pmu-events/arch/x86/IvyTown/Frontend.json |  305 ++
 tools/perf/pmu-events/arch/x86/IvyTown/Memory.json |  503 +++
 tools/perf/pmu-events/arch/x86/IvyTown/Other.json  |   44 +
 .../perf/pmu-events/arch/x86/IvyTown/Pipeline.json | 1307 ++++++
 .../arch/x86/IvyTown/Virtual-Memory.json           |  198 +
 tools/perf/pmu-events/arch/x86/Jaketown/Cache.json | 1290 ++++++
 .../arch/x86/Jaketown/Floating-point.json          |  138 +
 .../pmu-events/arch/x86/Jaketown/Frontend.json     |  305 ++
 .../perf/pmu-events/arch/x86/Jaketown/Memory.json  |  422 ++
 tools/perf/pmu-events/arch/x86/Jaketown/Other.json |   58 +
 .../pmu-events/arch/x86/Jaketown/Pipeline.json     | 1220 ++++++
 .../arch/x86/Jaketown/Virtual-Memory.json          |  149 +
 .../pmu-events/arch/x86/KnightsLanding/Cache.json  | 2305 +++++++++++
 .../arch/x86/KnightsLanding/Frontend.json          |   34 +
 .../pmu-events/arch/x86/KnightsLanding/Memory.json | 1110 +++++
 .../arch/x86/KnightsLanding/Pipeline.json          |  435 ++
 .../arch/x86/KnightsLanding/Virtual-Memory.json    |   65 +
 .../perf/pmu-events/arch/x86/NehalemEP/Cache.json  | 3229 +++++++++++++++
 .../arch/x86/NehalemEP/Floating-point.json         |  229 ++
 .../pmu-events/arch/x86/NehalemEP/Frontend.json    |   26 +
 .../perf/pmu-events/arch/x86/NehalemEP/Memory.json |  739 ++++
 .../perf/pmu-events/arch/x86/NehalemEP/Other.json  |  210 +
 .../pmu-events/arch/x86/NehalemEP/Pipeline.json    |  881 ++++
 .../arch/x86/NehalemEP/Virtual-Memory.json         |  109 +
 .../perf/pmu-events/arch/x86/NehalemEX/Cache.json  | 3184 +++++++++++++++
 .../arch/x86/NehalemEX/Floating-point.json         |  229 ++
 .../pmu-events/arch/x86/NehalemEX/Frontend.json    |   26 +
 .../perf/pmu-events/arch/x86/NehalemEX/Memory.json |  739 ++++
 .../perf/pmu-events/arch/x86/NehalemEX/Other.json  |  210 +
 .../pmu-events/arch/x86/NehalemEX/Pipeline.json    |  881 ++++
 .../arch/x86/NehalemEX/Virtual-Memory.json         |  109 +
 .../pmu-events/arch/x86/SandyBridge/Cache.json     | 1879 +++++++++
 .../arch/x86/SandyBridge/Floating-point.json       |  138 +
 .../pmu-events/arch/x86/SandyBridge/Frontend.json  |  305 ++
 .../pmu-events/arch/x86/SandyBridge/Memory.json    |  445 ++
 .../pmu-events/arch/x86/SandyBridge/Other.json     |   58 +
 .../pmu-events/arch/x86/SandyBridge/Pipeline.json  | 1220 ++++++
 .../arch/x86/SandyBridge/Virtual-Memory.json       |  149 +
 .../perf/pmu-events/arch/x86/Silvermont/Cache.json |  811 ++++
 .../pmu-events/arch/x86/Silvermont/Frontend.json   |   47 +
 .../pmu-events/arch/x86/Silvermont/Memory.json     |   11 +
 .../pmu-events/arch/x86/Silvermont/Pipeline.json   |  359 ++
 .../arch/x86/Silvermont/Virtual-Memory.json        |   69 +
 tools/perf/pmu-events/arch/x86/Skylake/Cache.json  | 4299 ++++++++++++++++++++
 .../arch/x86/Skylake/Floating-point.json           |   68 +
 .../perf/pmu-events/arch/x86/Skylake/Frontend.json |  472 +++
 tools/perf/pmu-events/arch/x86/Skylake/Memory.json | 2309 +++++++++++
 tools/perf/pmu-events/arch/x86/Skylake/Other.json  |   12 +
 .../perf/pmu-events/arch/x86/Skylake/Pipeline.json |  939 +++++
 .../arch/x86/Skylake/Virtual-Memory.json           |  272 ++
 .../pmu-events/arch/x86/WestmereEP-DP/Cache.json   | 2817 +++++++++++++
 .../arch/x86/WestmereEP-DP/Floating-point.json     |  229 ++
 .../arch/x86/WestmereEP-DP/Frontend.json           |   26 +
 .../pmu-events/arch/x86/WestmereEP-DP/Memory.json  |  758 ++++
 .../pmu-events/arch/x86/WestmereEP-DP/Other.json   |  287 ++
 .../arch/x86/WestmereEP-DP/Pipeline.json           |  899 ++++
 .../arch/x86/WestmereEP-DP/Virtual-Memory.json     |  173 +
 .../pmu-events/arch/x86/WestmereEP-SP/Cache.json   | 3233 +++++++++++++++
 .../arch/x86/WestmereEP-SP/Floating-point.json     |  229 ++
 .../arch/x86/WestmereEP-SP/Frontend.json           |   26 +
 .../pmu-events/arch/x86/WestmereEP-SP/Memory.json  |  739 ++++
 .../pmu-events/arch/x86/WestmereEP-SP/Other.json   |  287 ++
 .../arch/x86/WestmereEP-SP/Pipeline.json           |  899 ++++
 .../arch/x86/WestmereEP-SP/Virtual-Memory.json     |  149 +
 .../perf/pmu-events/arch/x86/WestmereEX/Cache.json | 3225 +++++++++++++++
 .../arch/x86/WestmereEX/Floating-point.json        |  229 ++
 .../pmu-events/arch/x86/WestmereEX/Frontend.json   |   26 +
 .../pmu-events/arch/x86/WestmereEX/Memory.json     |  747 ++++
 .../perf/pmu-events/arch/x86/WestmereEX/Other.json |  287 ++
 .../pmu-events/arch/x86/WestmereEX/Pipeline.json   |  905 ++++
 .../arch/x86/WestmereEX/Virtual-Memory.json        |  173 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   34 +
 139 files changed, 89806 insertions(+), 0 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Marked.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Other.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/PMC.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power8/Translation.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Bonnell/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Broadwell/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellDE/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/BroadwellX/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Goldmont/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Haswell/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/HaswellX/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyBridge/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/IvyTown/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Jaketown/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/KnightsLanding/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/KnightsLanding/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/KnightsLanding/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/KnightsLanding/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/KnightsLanding/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEP/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/NehalemEX/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/SandyBridge/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Silvermont/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Silvermont/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Silvermont/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Silvermont/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Silvermont/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/Skylake/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-DP/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEP-SP/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/WestmereEX/Virtual-Memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/mapfile.csv
