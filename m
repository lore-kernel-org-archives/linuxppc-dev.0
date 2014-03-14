Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: powerpc/perf: patches for 3.15
Date: Fri, 14 Mar 2014 16:00:25 +1100
Message-Id: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

This is the series of patches I have in my git tree to send to Ben.

https://github.com/mpe/powerpc-merge

These have all been to the list previously as-is, except for some of Cody's
which I've modified slightly to avoid depending on other peoples' trees.

The patch to fs/sysfs/group.c has already been merged by Greg, but we want to
carry it too so the code works prior to merging with his tree.

cheers

 Documentation/ABI/testing/sysfs-bus-event_source-devices-events  | 517 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 |  23 ++++
 Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci |  43 +++++++
 arch/powerpc/include/asm/cputable.h                              |   6 +-
 arch/powerpc/include/asm/hvcall.h                                |   5 +
 arch/powerpc/include/asm/perf_event_server.h                     |   1 +
 arch/powerpc/include/asm/reg.h                                   |   3 +
 arch/powerpc/kernel/cputable.c                                   |   2 +-
 arch/powerpc/perf/Makefile                                       |   2 +
 arch/powerpc/perf/core-book3s.c                                  | 172 ++++++++++++++++++++++++--
 arch/powerpc/perf/hv-24x7-catalog.h                              |  33 +++++
 arch/powerpc/perf/hv-24x7.c                                      | 510 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/hv-24x7.h                                      | 109 +++++++++++++++++
 arch/powerpc/perf/hv-common.c                                    |  39 ++++++
 arch/powerpc/perf/hv-common.h                                    |  36 ++++++
 arch/powerpc/perf/hv-gpci.c                                      | 294 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/hv-gpci.h                                      |  73 +++++++++++
 arch/powerpc/perf/power7-events-list.h                           |  10 ++
 arch/powerpc/perf/power8-pmu.c                                   |  78 +++++++++---
 arch/powerpc/platforms/pseries/Kconfig                           |  12 ++
 fs/sysfs/group.c                                                 |   7 +-
 21 files changed, 1941 insertions(+), 34 deletions(-)
