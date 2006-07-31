Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17613.38710.609255.581840@cargo.ozlabs.ibm.com>
Date: Mon, 31 Jul 2006 15:37:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Re: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get the commits listed below.

There is also a set of 5 patches for sound/aoa that need to go in
2.6.18.  I'm trying to coordinate with Takashi Iwai about whether he
or I will send you those.

Paul.

 arch/powerpc/Kconfig                         |    2 
 arch/powerpc/configs/pmac32_defconfig        |  112 ++++++++-
 arch/powerpc/kernel/head_64.S                |   35 +++
 arch/powerpc/kernel/legacy_serial.c          |   13 +
 arch/powerpc/kernel/misc_64.S                |    2 
 arch/powerpc/kernel/prom_init.c              |   36 +++
 arch/powerpc/kernel/smp.c                    |   24 +-
 arch/powerpc/kernel/udbg_16550.c             |    6 -
 arch/powerpc/mm/lmb.c                        |    3 
 arch/powerpc/platforms/chrp/setup.c          |   12 +
 arch/powerpc/platforms/maple/setup.c         |   17 +
 arch/powerpc/platforms/powermac/bootx_init.c |   35 ++-
 arch/powerpc/platforms/powermac/cpufreq_64.c |   78 ++++---
 arch/powerpc/platforms/pseries/setup.c       |    6 -
 drivers/ide/Kconfig                          |   14 -
 drivers/macintosh/Kconfig                    |   11 +
 drivers/macintosh/therm_pm72.c               |  218 +++++++++++++++++-
 drivers/macintosh/therm_pm72.h               |   33 +++
 drivers/macintosh/via-pmu-led.c              |    2 
 drivers/video/offb.c                         |  307 ++++++++++++++------------
 20 files changed, 703 insertions(+), 263 deletions(-)

Benjamin Herrenschmidt:
      [POWERPC] Workaround Pegasos incorrect ISA "ranges"
      [POWERPC] Fix 32 bits warning in prom_init.c
      [POWERPC] Fix non-MPIC CHRPs with CONFIG_SMP set
      [POWERPC] Fix default clock for udbg_16550
      [POWERPC] Fix legacy_serial.c error handling on 32 bits
      [POWERPC] More offb/bootx fixes
      [POWERPC] Xserve G5 thermal control fixes
      [POWERPC] Add cpufreq support for Xserve G5

Danny van Dyk:
      [POWERPC] PMAC_APM_EMU should depend on ADB_PMU

Geoff Levand:
      [POWERPC] Minor comment fix for misc_64.S

Jake Moilanen:
      [POWERPC] Use H_CEDE on non-SMT

Johannes Berg:
      [POWERPC] fix up front-LED Kconfig

Michael Ellerman:
      [POWERPC] Fix mem= handling when the memory limit is > RMO size

Olaf Hering:
      [POWERPC] force 64bit mode in fwnmi handlers to workaround firmware bugs

Segher Boessenkool:
      [POWERPC] Fix new interrupt code (MPIC endianness)
      [POWERPC] Fix new interrupt code (MPIC detection)
