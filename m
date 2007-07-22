Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18083.21499.799118.182647@cargo.ozlabs.ibm.com>
Date: Sun, 22 Jul 2007 22:56:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a further powerpc update for 2.6.23.

Thanks,
Paul.

 arch/powerpc/configs/prpmc2800_defconfig   |    2 +-
 arch/powerpc/kernel/pci-common.c           |    2 +-
 arch/powerpc/kernel/prom.c                 |    2 +-
 arch/powerpc/kernel/smp.c                  |    7 +++++-
 arch/powerpc/mm/fault.c                    |    8 ++++++-
 arch/powerpc/mm/hash_utils_64.c            |    4 ++--
 arch/powerpc/platforms/Kconfig.cputype     |    2 +-
 arch/powerpc/platforms/embedded6xx/Kconfig |    2 +-
 arch/powerpc/platforms/pseries/firmware.c  |   19 +++--------------
 arch/powerpc/platforms/pseries/pseries.h   |    2 +-
 arch/powerpc/platforms/pseries/setup.c     |   17 ++++++++++-----
 arch/powerpc/sysdev/mpic.c                 |   32 ++++++++++++++++++++++++++++
 arch/powerpc/xmon/nonstdio.c               |    5 ++++
 arch/powerpc/xmon/nonstdio.h               |    3 ++-
 arch/powerpc/xmon/start.c                  |    2 +-
 arch/powerpc/xmon/xmon.c                   |    2 +-
 arch/ppc/syslib/mv64x60.c                  |   15 +++++++------
 drivers/char/hvc_iseries.c                 |    8 ++++---
 drivers/char/hvc_rtas.c                    |    2 +-
 drivers/char/hvcs.c                        |    8 ++++---
 drivers/macintosh/rack-meter.c             |    1 -
 drivers/pcmcia/m8xx_pcmcia.c               |    2 +-
 include/asm-powerpc/mpic.h                 |    3 +++
 include/asm-powerpc/prom.h                 |    2 +-
 include/asm-ppc/system.h                   |    1 +
 include/linux/of_platform.h                |    4 ++--
 26 files changed, 101 insertions(+), 56 deletions(-)

Avi Kivity (1):
      [POWERPC] Allow smp_call_function_single() to current cpu

Benjamin Herrenschmidt (1):
      [POWERPC] MPIC protected sources

Christoph Hellwig (1):
      [POWERPC] mv64x60: Use mutex instead of semaphore

Geert Uytterhoeven (1):
      [POWERPC] cell: CONFIG_SPE_BASE is a typo

Ishizaki Kou (2):
      [POWERPC] Make xmon_write accept a const buffer
      [POWERPC] fix showing xmon help

Jesper Juhl (1):
      [POWERPC] Clean up duplicate includes in drivers/macintosh/

Josh Boyer (1):
      [POWERPC] Fix ARCH=ppc builds

Michael Neuling (1):
      [POWERPC] Fix future firmware feature fixups function failure

Paul Mackerras (1):
      [POWERPC] Allow exec faults on readable areas on classic 32-bit PowerPC

Robert P. J. Day (1):
      [POWERPC] Fix misspelled "CONFIG_CHECK_CACHE_COHERENCY" Kconfig option.

Segher Boessenkool (1):
      [POWERPC] of_detach_node()'s device node argument cannot be const

Stephen Rothwell (6):
      [POWERPC] Constify of_platform_driver name
      [POWERPC] hvcs: Make some things static and const
      [POWERPC] Constify of_platform_driver match_table
      [POWERPC] Quiet section mismatch in hvc_rtas.c
      [POWERPC] init and exit markings for hvc_iseries
      [POWERPC] Quiet section mismatch warning on pcibios_setup
