Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18259.35326.516899.603549@cargo.ozlabs.ibm.com>
Date: Mon, 3 Dec 2007 15:45:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: for-2.6.25 branch created in powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have created a for-2.6.25 branch in my powerpc.git repository and
added the patches listed below to it.  The master branch points to the
same place as the for-2.6.25 branch.

Paul.

Benjamin Herrenschmidt (2):
      [POWERPC] Cleanup SMT thread handling
      [POWERPC] Add xmon function to dump 44x TLB

Johannes Berg (3):
      [POWERPC] powermac: Fix warning in time.c
      [POWERPC] PMU: Don't lock_kernel()
      [POWERPC] PMU: Remove dead code

Linas Vepstas (3):
      [POWERPC] EEH: Work with device endpoint, always
      [POWERPC] EEH: Be careful when identifying "empty" slots.
      [POWERPC] EEH: Report errors as soon as possible

Nathan Lynch (1):
      [POWERPC] Remove prod_processor()

Stephen Rothwell (5):
      [POWERPC] Make global_phb_number static
      [POWERPC] iSeries: Mark two functions __init
      [POWERPC] iSeries: Declare iSeries_pci_final_fixup in pci.h
      [POWERPC] iSeries: Fix sparse warnings in setup.c
      [POWERPC] Remove redundant declaration of hose_list

joe@perches.com (2):
      [POWERPC] Add missing spaces in printk formats
      [POWERPC] Add missing spaces in printk formats in arch/ppc

 arch/powerpc/kernel/isa-bridge.c                |    4 +
 arch/powerpc/kernel/pci-common.c                |    4 -
 arch/powerpc/kernel/setup-common.c              |   78 +++++++++++++++++++----
 arch/powerpc/mm/fault.c                         |    2 -
 arch/powerpc/platforms/8xx/m8xx_setup.c         |    2 -
 arch/powerpc/platforms/cell/smp.c               |    3 +
 arch/powerpc/platforms/celleb/io-workarounds.c  |    2 -
 arch/powerpc/platforms/celleb/scc_epci.c        |    2 -
 arch/powerpc/platforms/iseries/pci.c            |    4 +
 arch/powerpc/platforms/iseries/pci.h            |    5 +
 arch/powerpc/platforms/iseries/setup.c          |   22 +++---
 arch/powerpc/platforms/iseries/setup.h          |    1 
 arch/powerpc/platforms/powermac/time.c          |    2 +
 arch/powerpc/platforms/pseries/eeh.c            |    3 +
 arch/powerpc/platforms/pseries/eeh_driver.c     |   15 ++--
 arch/powerpc/platforms/pseries/plpar_wrappers.h |    5 -
 arch/powerpc/platforms/pseries/smp.c            |    3 +
 arch/powerpc/sysdev/fsl_pci.c                   |    2 -
 arch/powerpc/xmon/xmon.c                        |   38 +++++++++++
 arch/ppc/platforms/ev64260.c                    |    4 +
 drivers/macintosh/via-pmu.c                     |   45 -------------
 include/asm-powerpc/cputhreads.h                |   71 +++++++++++++++++++++
 include/asm-powerpc/ppc-pci.h                   |    1 
 23 files changed, 218 insertions(+), 100 deletions(-)
 create mode 100644 include/asm-powerpc/cputhreads.h
