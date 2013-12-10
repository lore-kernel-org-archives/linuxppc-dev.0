Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6774A2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 12:57:58 +1100 (EST)
Message-ID: <1386640667.32037.53.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Dec 2013 12:57:47 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a handful of powerpc fixes for 3.13.

The patches are reasonably trivial and self contained. Note the
offb patches outside of arch/powerpc, they are LE fixes for our
open-firmware "dumb" framebuffer.

Cheers,
Ben.

The following changes since commit 721cb59e9d95eb7f47ec73711ed35ef85e1ea1ca:

  powerpc/windfarm: Fix XServe G5 fan control Makefile issue (2013-11-27 11:35:47 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to e641eb03ab2b0f065fa5e64b4202fb5b0441b427:

  powerpc: Fix up the kdump base cap to 128M (2013-12-10 11:28:39 +1100)

----------------------------------------------------------------
Anatolij Gustschin (1):
      powerpc/52xx: Re-enable bestcomm driver in defconfigs

Cedric Le Goater (2):
      offb: Little endian fixes
      offb: Add palette hack for little endian

Gerhard Sittig (1):
      powerpc/512x: dts: remove misplaced IRQ spec from 'soc' node

Hong H. Pham (1):
      powerpc: Fix PTE page address mismatch in pgtable ctor/dtor

Ilia Mirkin (1):
      powerpc/44x: Fix ocm_block allocation

Mahesh Salgaonkar (1):
      powerpc: Fix up the kdump base cap to 128M

Michael Ellerman (1):
      powerpc: Fix build break with PPC_EARLY_DEBUG_BOOTX=y

Olof Johansson (1):
      powerpc/pasemi: Turn on devtmpfs in defconfig

Thadeu Lima de Souza Cascardo (1):
      powernv: Fix VFIO support with PHB3

 arch/powerpc/boot/dts/mpc5121.dtsi            |  1 -
 arch/powerpc/configs/52xx/cm5200_defconfig    |  3 ++-
 arch/powerpc/configs/52xx/lite5200b_defconfig |  3 ++-
 arch/powerpc/configs/52xx/motionpro_defconfig |  3 ++-
 arch/powerpc/configs/52xx/pcm030_defconfig    |  3 ++-
 arch/powerpc/configs/52xx/tqm5200_defconfig   |  3 ++-
 arch/powerpc/configs/mpc5200_defconfig        |  3 ++-
 arch/powerpc/configs/pasemi_defconfig         |  7 +++----
 arch/powerpc/include/asm/pgalloc-32.h         |  6 ++----
 arch/powerpc/include/asm/pgalloc-64.h         |  6 ++----
 arch/powerpc/kernel/machine_kexec.c           |  2 +-
 arch/powerpc/kernel/misc_64.S                 |  5 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c     |  1 +
 arch/powerpc/sysdev/ppc4xx_ocm.c              |  2 +-
 drivers/video/offb.c                          | 29 +++++++++++++++++++--------
 15 files changed, 47 insertions(+), 30 deletions(-)
