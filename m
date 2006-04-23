Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17482.54553.159397.400323@cargo.ozlabs.ibm.com>
Date: Sun, 23 Apr 2006 11:15:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

to get the following powerpc bug-fixes, and a defconfig update.

Thanks,
Paul.

Arnd Bergmann:
      powerpc/cell: remove BUILD_BUG_ON and add sys_tee to spu_syscall_table

Becky Bruce:
      ppc: Fix powersave code on arch/ppc

Benjamin Herrenschmidt:
      powermac: Fix i2c on keywest based chips
      powerpc: fix oops in alsa powermac driver

Kumar Gala:
      powerpc/ppc: export strncasecmp

Olof Johansson:
      powerpc: IOMMU support for honoring dma_mask
      powerpc: Lower threshold for DART enablement to 1GB

Paul Mackerras:
      powerpc: Fix define_machine so machine_is() works from modules

Will Schmidt:
      powerpc: update {g5,iseries,pseries}_defconfigs

 arch/powerpc/configs/g5_defconfig           |   58 ++++++++++----------
 arch/powerpc/configs/iseries_defconfig      |   43 +++++++++------
 arch/powerpc/configs/pseries_defconfig      |   54 +++++++++----------
 arch/powerpc/kernel/iommu.c                 |   38 +++++++++----
 arch/powerpc/kernel/pci_iommu.c             |   42 +++++++++++++--
 arch/powerpc/kernel/ppc_ksyms.c             |    1 
 arch/powerpc/kernel/prom.c                  |    2 -
 arch/powerpc/kernel/systbl.S                |    5 ++
 arch/powerpc/kernel/vio.c                   |    6 +-
 arch/powerpc/platforms/cell/spu_callbacks.c |    5 +-
 arch/powerpc/platforms/powermac/low_i2c.c   |   78 ++++++++++++---------------
 arch/powerpc/sysdev/dart_iommu.c            |   12 +++-
 arch/ppc/kernel/asm-offsets.c               |    1 
 arch/ppc/kernel/entry.S                     |   35 ++++++------
 arch/ppc/kernel/ppc_ksyms.c                 |    1 
 drivers/macintosh/therm_adt746x.c           |    4 +
 include/asm-powerpc/iommu.h                 |    7 +-
 include/asm-powerpc/machdep.h               |    6 ++
 sound/oss/dmasound/tas_common.c             |    4 +
 sound/ppc/daca.c                            |    2 -
 sound/ppc/tumbler.c                         |    2 -
 21 files changed, 234 insertions(+), 172 deletions(-)
