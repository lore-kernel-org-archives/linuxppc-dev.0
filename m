Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 40F4E2C008A
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2012 17:33:32 +1000 (EST)
Message-ID: <1343720005.8227.24.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Jul 2012 17:33:25 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

Kumar sent me a handful of Freescale related fixes and I added
another regression fix to the pile.

Cheers,
Ben.

PS. I -will- eventually learn about that signed tag business :-)

The following changes since commit 1fad1e9a747687a7399bf58e87974f9b1bbcae06:

  Merge tag 'nfs-for-3.6-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2012-07-30 19:16:57 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to ad36cb0d1d3e2b7f161cd33932433f9349cade1e:

  powerpc/kvm/book3s_32: Fix MTMSR_EERI macro (2012-07-31 15:21:20 +1000)

----------------------------------------------------------------
Alexander Graf (1):
      powerpc/kvm/book3s_32: Fix MTMSR_EERI macro

Benjamin Herrenschmidt (1):
      Merge remote-tracking branch 'kumar/merge' into merge

Claudiu Manoil (1):
      powerpc/85xx: Fix sram_offset parameter type

Shaohui Xie (1):
      powerpc/85xx: P3041DS - change espi input-clock from 40MHz to 35MHz

Tang Yuantian (1):
      powerpc/85xx: Fix pci base address error for p2020rdb-pc in dts

Timur Tabi (2):
      powerpc/85xx: p1022ds: disable the NAND flash node if video is enabled
      powerpc/85xx: p1022ds: fix DIU/LBC switching with NAND enabled

 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts |    4 +-
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/p3041ds.dts         |    2 +-
 arch/powerpc/kvm/book3s_rmhandlers.S      |    1 -
 arch/powerpc/platforms/85xx/p1022_ds.c    |  122 +++++++++++++++++++++++------
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 ++++-----
 7 files changed, 121 insertions(+), 55 deletions(-)
