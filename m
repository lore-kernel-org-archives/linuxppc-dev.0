Return-Path: <geoff@infradead.org>
Message-Id: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [GIT PULL] PS3 updates for Linux-3.5
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2012 19:19:34 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 Hector Martin <hector@marcansoft.com>, Valentin Ilie <valentin.ilie@gmail.com>,
 Nathan Whitehorn <nwhitehorn@freebsd.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

I queued up the PS3 updates I have for v3.5.  Please pull.

-Geoff

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

for you to fetch changes up to 3252c8a3d0bf3c6af6ce7c76c40444943cda2943:

  powerpc/ps3: Refresh ps3_defconfig (2012-04-24 18:18:01 -0700)

----------------------------------------------------------------
Andre Heider (3):
      powerpc/ps3: Add highmem repository read routines
      powerpc/ps3: Use highmem region from repository
      powerpc/ps3: Remove MEMORY_HOTPLUG requirement

Geoff Levand (5):
      powerpc/ps3: Correct lv1 repository routine names
      powerpc/ps3: Add PS3 repository write support
      powerpc/ps3: Add highmem repository write routines
      powerpc/ps3: Minor Kconfig cleanup
      powerpc/ps3: Refresh ps3_defconfig

Hector Martin (1):
      powerpc/ps3: Add highmem region memory early

Valentin Ilie (1):
      drivers/ps3: Fix checkpatch warnings in ps3av.c

 arch/powerpc/configs/ps3_defconfig      |    6 -
 arch/powerpc/include/asm/lv1call.h      |    4 +-
 arch/powerpc/platforms/ps3/Kconfig      |   22 +++-
 arch/powerpc/platforms/ps3/mm.c         |   77 ++++++------
 arch/powerpc/platforms/ps3/platform.h   |   16 +++
 arch/powerpc/platforms/ps3/repository.c |  198 +++++++++++++++++++++++++++++++
 drivers/ps3/ps3av.c                     |   24 ++--
 7 files changed, 281 insertions(+), 66 deletions(-)

Andre Heider (3):
  powerpc/ps3: Add highmem repository read routines
  powerpc/ps3: Use highmem region from repository
  powerpc/ps3: Remove MEMORY_HOTPLUG requirement

Geoff Levand (5):
  powerpc/ps3: Correct lv1 repository routine names
  powerpc/ps3: Add PS3 repository write support
  powerpc/ps3: Add highmem repository write routines
  powerpc/ps3: Minor Kconfig cleanup
  powerpc/ps3: Refresh ps3_defconfig

Hector Martin (1):
  powerpc/ps3: Add highmem region memory early

Valentin Ilie (1):
  drivers/ps3: Fix checkpatch warnings in ps3av.c

 arch/powerpc/configs/ps3_defconfig      |    6 -
 arch/powerpc/include/asm/lv1call.h      |    4 +-
 arch/powerpc/platforms/ps3/Kconfig      |   22 +++-
 arch/powerpc/platforms/ps3/mm.c         |   77 ++++++------
 arch/powerpc/platforms/ps3/platform.h   |   16 +++
 arch/powerpc/platforms/ps3/repository.c |  198 +++++++++++++++++++++++++++++++
 drivers/ps3/ps3av.c                     |   24 ++--
 7 files changed, 281 insertions(+), 66 deletions(-)

-- 
1.7.9.5
