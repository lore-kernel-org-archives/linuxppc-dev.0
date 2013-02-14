Return-Path: <geoff@infradead.org>
Message-Id: <cover.1360810584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/4] PS3 patches for 3.9
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2013 03:06:19 +0000
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here are a few minor PS3 patches, and one cleanup for the powerpc
boot_paca variable.

Please consider for 3.9

-Geoff

The following changes since commit 836dc9e3fbbab0c30aa6e664417225f5c1fb1c39:

  Linux 3.8-rc7 (2013-02-09 08:20:39 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

for you to fetch changes up to f9fda8ea9d2ef07dd5b3313892ec20b6cbad2ce8:

  powerpc: Move boot_paca into early_setup (2013-02-13 18:07:41 -0800)

----------------------------------------------------------------
Geoff Levand (4):
      powerpc/ps3: Add macro PS3_VERBOSE_RESULT
      powerpc/ps3: Increase verbosity of htab errors
      powerpc/ps3: Refresh ps3_defconfig
      powerpc: Move boot_paca into early_setup

 arch/powerpc/configs/ps3_defconfig |   15 +++++++++------
 arch/powerpc/include/asm/paca.h    |    1 -
 arch/powerpc/include/asm/ps3.h     |    2 +-
 arch/powerpc/kernel/paca.c         |    2 --
 arch/powerpc/kernel/setup_64.c     |    2 ++
 arch/powerpc/platforms/ps3/htab.c  |   14 ++++++++------
 6 files changed, 20 insertions(+), 16 deletions(-)
