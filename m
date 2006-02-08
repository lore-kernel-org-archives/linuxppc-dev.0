Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17385.28412.412453.697990@cargo.ozlabs.ibm.com>
Date: Wed, 8 Feb 2006 15:09:32 +1100
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

Log and diffstat follow.

Thanks,
Paul.

Becky Bruce:
      documentation/powerpc: add bus-frequency property to SOC node

Dave C Boutcher:
      powerpc: return correct rtas status from ibm,suspend-me
      powerpc: prod all processors after ibm,suspend-me
      powerpc: remove useless call to touch_softlockup_watchdog

David Gibson:
      powerpc: Cleanup, consolidating icache dirtying logic

Geoff Levand:
      powerpc: Fix spufs initialization sequence.

Ingo Molnar:
      sem2mutex: drivers/macintosh/windfarm_core.c

Jake Moilanen:
      powerpc: IOMMU SG paranoia

Jesper Juhl:
      Don't check pointer for NULL before passing it to kfree [arch/powerpc/kernel/rtas_flash.c]

Marcelo Tosatti:
      powerpc/8xx: last two 8MB D-TLB entries are incorrectly set

Michael Ellerman:
      powerpc: Don't allocate zero bytes in finish_device_tree()
      powerpc: Make sure we don't create empty lmb regions
      powerpc: Refuse to boot a kdump kernel via OF
      powerpc: Fix !SMP build of rtas.c
      powerpc: Don't overwrite flat device tree with kdump kernel
      powerpc: Don't use toc in decrementer_iSeries_masked

Michael Neuling:
      powerpc: hypervisor check in pseries_kexec_cpu_down

Nathan Lynch:
      powerpc: avoid timer interrupt replay effect when onlining cpu

Olaf Hering:
      powerpc: remove pointer/integer confusion in generic_calibrate_decr
      powerpc: restore clock speed in /proc/cpuinfo
      powerpc: remove pointer/integer confusion in of_find_node_by_name
      powerpc: add refcounting to setup_peg2 and of_get_pci_address
      powerpc: fix compile warning in udbg_init_maple_realmode

Paul Mackerras:
      powerpc/64: Fix bug in setting floating-point exception mode

 Documentation/powerpc/booting-without-of.txt |    8 ++++
 arch/powerpc/kernel/fpu.S                    |    2 -
 arch/powerpc/kernel/head_64.S                |    5 +-
 arch/powerpc/kernel/iommu.c                  |    9 +++-
 arch/powerpc/kernel/prom.c                   |   38 +++++++++++++++++--
 arch/powerpc/kernel/prom_init.c              |    4 ++
 arch/powerpc/kernel/prom_parse.c             |    4 +-
 arch/powerpc/kernel/rtas.c                   |   12 +++---
 arch/powerpc/kernel/rtas_flash.c             |    3 -
 arch/powerpc/kernel/setup_64.c               |    3 +
 arch/powerpc/kernel/smp.c                    |    3 +
 arch/powerpc/kernel/time.c                   |    8 ++--
 arch/powerpc/kernel/udbg_16550.c             |    2 -
 arch/powerpc/mm/lmb.c                        |    4 ++
 arch/powerpc/mm/mem.c                        |   14 +------
 arch/powerpc/platforms/cell/Makefile         |    2 -
 arch/powerpc/platforms/chrp/chrp.h           |    1 
 arch/powerpc/platforms/chrp/pci.c            |    2 +
 arch/powerpc/platforms/chrp/setup.c          |    2 -
 arch/powerpc/platforms/chrp/time.c           |   21 ----------
 arch/powerpc/platforms/pseries/setup.c       |    2 -
 arch/ppc/kernel/head_8xx.S                   |    7 ++-
 drivers/macintosh/windfarm_core.c            |   53 +++++++++++++-------------
 include/asm-powerpc/prom.h                   |    2 +
 24 files changed, 123 insertions(+), 88 deletions(-)
