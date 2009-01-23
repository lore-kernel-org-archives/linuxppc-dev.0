Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 570AADDEE4
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 01:03:54 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id l24so1542507waf.9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 06:03:52 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 23 Jan 2009 09:03:44 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'merge' branch of 4xx git tree
Message-ID: <20090123140344.GA17808@yoda.jdub.homelinux.org>
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

Please pull the following changes for 2.6.29.  Mostly defconfig
updates, but a few smaller fixes as well.

thx,
josh

The following changes since commit f3b8436ad9a8ad36b3c9fa1fe030c7f38e5d3d0b:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../roland/infiniband

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Grant Erickson (1):
      powerpc/4xx: DTS: Add Add'l SDRAM0 Compatible and Interrupt Info

Josh Boyer (3):
      powerpc/40x: Update PowerPC 40x defconfigs
      powerpc/44x: Update PowerPC 44x defconfigs
      powerpc/4xx: Update multi-board PowerPC 4xx defconfigs

Sean MacLennan (1):
      powerpc/44x: Warp patches for the new NDFC driver

 arch/powerpc/boot/cuboot-warp.c                |   43 -------
 arch/powerpc/boot/dts/haleakala.dts            |    5 +-
 arch/powerpc/boot/dts/kilauea.dts              |    5 +-
 arch/powerpc/boot/dts/makalu.dts               |    5 +-
 arch/powerpc/boot/dts/warp.dts                 |   42 +++++++-
 arch/powerpc/configs/40x/acadia_defconfig      |   76 ++++++++++----
 arch/powerpc/configs/40x/ep405_defconfig       |   87 +++++++++++----
 arch/powerpc/configs/40x/hcu4_defconfig        |   78 ++++++++++----
 arch/powerpc/configs/40x/kilauea_defconfig     |   76 ++++++++++----
 arch/powerpc/configs/40x/makalu_defconfig      |   76 ++++++++++----
 arch/powerpc/configs/40x/virtex_defconfig      |   53 ++++++---
 arch/powerpc/configs/40x/walnut_defconfig      |   84 +++++++++++----
 arch/powerpc/configs/44x/arches_defconfig      |   60 +++++++---
 arch/powerpc/configs/44x/bamboo_defconfig      |   76 +++++++++----
 arch/powerpc/configs/44x/canyonlands_defconfig |   60 +++++++---
 arch/powerpc/configs/44x/ebony_defconfig       |   84 +++++++++++----
 arch/powerpc/configs/44x/katmai_defconfig      |   76 +++++++++----
 arch/powerpc/configs/44x/rainier_defconfig     |   83 +++++++++++----
 arch/powerpc/configs/44x/sam440ep_defconfig    |   77 +++++++++----
 arch/powerpc/configs/44x/sequoia_defconfig     |   83 +++++++++++----
 arch/powerpc/configs/44x/taishan_defconfig     |   83 +++++++++++----
 arch/powerpc/configs/44x/virtex5_defconfig     |   53 ++++++---
 arch/powerpc/configs/44x/warp_defconfig        |  140 ++++++++++++++++++------
 arch/powerpc/configs/ppc40x_defconfig          |   77 ++++++++++---
 arch/powerpc/configs/ppc44x_defconfig          |   79 ++++++++++---
 arch/powerpc/platforms/44x/Makefile            |    1 -
 arch/powerpc/platforms/44x/warp-nand.c         |  135 -----------------------
 27 files changed, 1204 insertions(+), 593 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/warp-nand.c
