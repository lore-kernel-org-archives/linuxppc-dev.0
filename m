Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17637.8568.40692.21510@cargo.ozlabs.ibm.com>
Date: Fri, 18 Aug 2006 12:10:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: gregkh@suse.de, linuxppc-dev@ozlabs.org
Subject: Please pull powerpc.git 'merge' branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get the following PowerPC updates for 2.6.18.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |   10 -
 arch/powerpc/Kconfig                         |    7 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |  339 ++++++++++++++++++++++++++
 arch/powerpc/configs/g5_defconfig            |  122 ++++++++-
 arch/powerpc/configs/iseries_defconfig       |   78 +++++-
 arch/powerpc/configs/pseries_defconfig       |   78 +++++-
 arch/powerpc/kernel/Makefile                 |    4 
 arch/powerpc/kernel/cpu_setup_power4.S       |    2 
 arch/powerpc/kernel/crash.c                  |   11 +
 arch/powerpc/kernel/irq.c                    |    2 
 arch/powerpc/kernel/kprobes.c                |    2 
 arch/powerpc/kernel/machine_kexec.c          |   56 ++++
 arch/powerpc/kernel/machine_kexec_64.c       |   57 ----
 arch/powerpc/kernel/rtas.c                   |   21 ++
 arch/powerpc/kernel/traps.c                  |   16 +
 arch/powerpc/platforms/pseries/setup.c       |    2 
 arch/powerpc/platforms/pseries/xics.c        |    6 
 arch/powerpc/sysdev/fsl_soc.c                |   12 +
 include/asm-powerpc/kexec.h                  |    3 
 include/asm-powerpc/rtas.h                   |    1 
 20 files changed, 695 insertions(+), 134 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8641_hpcn.dts

Ananth N Mavinakayanahalli:
      [POWERPC] kprobes: Fix possible system crash during out-of-line single-stepping

Benjamin Herrenschmidt:
      [POWERPC] Fix irq radix tree remapping typo

David Wilder:
      [POWERPC] Make secondary CPUs call into kdump on reset exception

Haren Myneni:
      [POWERPC] Fix might-sleep warning on removing cpus

Jon Loeliger:
      [POWERPC] Convert to mac-address for ethernet MAC address data.
      [POWERPC] Add MPC8641 HPCN Device Tree Source file.
      [POWERPC] Offer PCI as a CONFIG choice for PPC_86xx.
      [POWERPC] Fix the mpc8641_hpcn.dts file.

Michael Ellerman:
      [POWERPC] Move some kexec logic into machine_kexec.c
      [POWERPC] Make crash.c work on 32-bit and 64-bit

Olof Johansson:
      [POWERPC] powerpc: Clear HID0 attention enable on PPC970 at boot time

Sonny Rao:
      [POWERPC] fix PMU initialization on pseries lpar

Will Schmidt:
      [POWERPC] update {g5,iseries,pseries}_defconfigs
