Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id E8F6CDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 01:08:20 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so2712571wfd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 06:08:19 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 24 Feb 2009 09:08:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch
Message-ID: <20090224140800.GA2323@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Please pull the next branch of the 4xx tree.  It has a few small commits
for 2.6.30, as well as the 256K page size patch for 44x.

josh

The following changes since commit 6071ed0487c6ea8dcfadd9844b9b90944cd9de1e:
  Michael Ellerman (1):
        powerpc/pseries: Return the number of MSIs we could allocate

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Benjamin Herrenschmidt (2):
      powerpc/4xx: Add missing USB and i2c devices to Canyonlands
      powerpc/4xx: Enable PCI domains on 4xx

Madhulika Madishetty (1):
      AMCC PPC 460SX redwood SoC platform initial framework

Yuri Tikhonov (1):
      powerpc/44x: Support for 256KB PAGE_SIZE

 arch/powerpc/Kconfig                           |   27 +
 arch/powerpc/boot/dts/canyonlands.dts          |   28 +
 arch/powerpc/boot/dts/redwood.dts              |  244 +++++
 arch/powerpc/configs/44x/canyonlands_defconfig |  266 +++++-
 arch/powerpc/configs/44x/redwood_defconfig     | 1176 ++++++++++++++++++++++++
 arch/powerpc/include/asm/highmem.h             |   10 +-
 arch/powerpc/include/asm/mmu-44x.h             |    2 +
 arch/powerpc/include/asm/page.h                |    6 +-
 arch/powerpc/include/asm/page_32.h             |    4 +
 arch/powerpc/include/asm/thread_info.h         |    4 +-
 arch/powerpc/kernel/cpu_setup_44x.S            |    1 +
 arch/powerpc/kernel/cputable.c                 |   14 +
 arch/powerpc/kernel/head_booke.h               |   11 +-
 arch/powerpc/platforms/44x/Kconfig             |   19 +
 arch/powerpc/platforms/44x/ppc44x_simple.c     |    1 +
 arch/powerpc/sysdev/ppc4xx_pci.c               |    2 +
 16 files changed, 1796 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/redwood.dts
 create mode 100644 arch/powerpc/configs/44x/redwood_defconfig
