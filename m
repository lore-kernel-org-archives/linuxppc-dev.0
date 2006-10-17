Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17716.21966.460995.119765@cargo.ozlabs.ibm.com>
Date: Tue, 17 Oct 2006 14:02:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some more PowerPC bugfixes, as listed below.

Paul.

 arch/powerpc/configs/mpc834x_itx_defconfig |    2 +-
 arch/powerpc/kernel/cputable.c             |    2 +-
 arch/powerpc/kernel/pci_32.c               |   12 ++++++------
 arch/powerpc/kernel/pci_64.c               |   10 ++++++++--
 arch/powerpc/kernel/process.c              |   10 ++--------
 arch/powerpc/kernel/traps.c                |    3 +--
 arch/powerpc/platforms/83xx/Kconfig        |   13 +++++++++++++
 arch/powerpc/platforms/83xx/Makefile       |    2 ++
 arch/powerpc/platforms/83xx/mpc8360e_pb.c  |   19 +++++++++++++++++++
 arch/powerpc/platforms/cell/spu_base.c     |   15 +++++++++++----
 arch/powerpc/platforms/cell/spufs/file.c   |    1 +
 arch/ppc/kernel/time.c                     |    4 ++++
 arch/ppc/platforms/mpc8272ads_setup.c      |    4 ++--
 arch/ppc/platforms/mpc866ads_setup.c       |    4 ++--
 arch/ppc/platforms/mpc885ads_setup.c       |    4 ++--
 15 files changed, 75 insertions(+), 30 deletions(-)

Anton Blanchard:
      [POWERPC] Never panic when taking altivec exceptions from userspace
      [POWERPC] POWER6 has 6 PMCs
      [POWERPC] Better check in show_instructions
      [POWERPC] Check for offline nodes in pci NUMA code

Benjamin Herrenschmidt:
      [POWERPC] Don't crash on cell with 2 BEs when !CONFIG_NUMA

Eric Sesterhenn:
      [POWERPC] Off-by-one in /arch/ppc/platforms/mpc8*

Kumar Gala:
      [POWERPC] ppc: Add missing calls to set_irq_regs

Li Yang:
      [POWERPC] Fix MPC8360EMDS PB board support
      [POWERPC] Add Makefile entry for MPC832x_mds support

Noguchi, Masato:
      [POWERPC] spufs: fix support for read/write on cntl

Randy Vinson:
      [POWERPC] Fix IO Window Updates on P2P bridges.

Timur Tabi:
      [POWERPC] Add DOS partition table support to mpc834x_itx_defconfig
