Return-Path: <geoff@infradead.org>
Message-Id: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [GIT PULL] PS3 updates for powerpc next
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:49 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, David
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here are the PS3 updates for 3.3.

The patch 'powerpc/ps3: Fix hcall lv1_net_stop_rx_dma' includes a trivial
change to the ps3_gelic_net driver in drivers/net.


-Geoff

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:
  Linus Torvalds (1):
        Linux 3.2-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

Geoff Levand (8):
      powerpc/ps3: Interrupt code cleanup
      powerpc/ps3: Fix hcall lv1_net_stop_rx_dma
      powerpc/ps3: Fix hcall lv1_get_virtual_address_space_id_of_ppe
      powerpc/ps3: Fix hcall lv1_get_version_info
      powerpc/ps3: Fix hcall lv1_read_repository_node
      powerpc/ps3: Fix pr_debug build warnings
      powerpc/ps3: Add __init to ps3_smp_probe
      powerpc/ps3: Update ps3_defconfig

 arch/powerpc/configs/ps3_defconfig           |   39 +++++-----
 arch/powerpc/include/asm/lv1call.h           |   10 +-
 arch/powerpc/kernel/irq.c                    |    4 +-
 arch/powerpc/platforms/ps3/interrupt.c       |  103 +++++++++++++-------------
 arch/powerpc/platforms/ps3/repository.c      |   18 +++--
 arch/powerpc/platforms/ps3/setup.c           |    4 +-
 arch/powerpc/platforms/ps3/smp.c             |    2 +-
 arch/powerpc/platforms/ps3/spu.c             |    2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |    4 +-
 9 files changed, 97 insertions(+), 89 deletions(-)
