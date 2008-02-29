Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: Please pull 'for-2.6.25' branch of cell tree
Date: Fri, 29 Feb 2008 06:12:56 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802290612.56728.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.25

To pick up a few small fixes for the cell platform. Most of it is a follow-up
to the IOMMU rework that got merged in 2.6.25-rc1 and caused problems on
machines with large amounts of memory.

The fixes for oprofile and ptrace are not regressions, but are fixing
functionality that was broken on cell but has always worked on the
other platforms.

Thanks,

	Arnd <><

Author: Michael Ellerman <michael@ellerman.id.au>
    [POWERPC] Convert the cell IOMMU fixed mapping to 16M IOMMU pages
    [POWERPC] Allow for different IOMMU page sizes in cell IOMMU code
    [POWERPC] Cell IOMMU: n_pte_pages is in 4K page units, not IOMMU_PAGE_SIZE
    [POWERPC] Split setup of IOMMU stab and ptab, allocate dynamic/fixed ptabs separately
    [POWERPC] Move allocation of cell IOMMU pad page
    [POWERPC] Remove unused pte_offset variable
    [POWERPC] Use it_offset not pte_offset in cell IOMMU code
    [POWERPC] Clearup cell IOMMU fixed mapping terminology

Author: Jens Osterkamp <jens@de.ibm.com>
    [POWERPC] enable hardware watchpoints on cell blades
    [POWERPC] move celleb DABRX definitions

Author: Bob Nelson <rrnelson@us.ibm.com>
    [POWERPC] OProfile: enable callgraph support for Cell

 arch/powerpc/oprofile/op_model_cell.c |    2
 arch/powerpc/platforms/cell/iommu.c   |  144 +++++++++++++++++++---------------
 arch/powerpc/platforms/cell/setup.c   |    7 +
 arch/powerpc/platforms/celleb/beat.h  |    3
 include/asm-powerpc/reg.h             |    3
 5 files changed, 92 insertions(+), 67 deletions(-)
