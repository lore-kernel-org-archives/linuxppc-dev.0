Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A1F79B6F68
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jan 2012 14:01:25 +1100 (EST)
Message-ID: <1327460475.19850.51.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Jan 2012 14:01:15 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few fixes on top of rc1, a couple of important compile
regressions and a couple of minor embedded additions.

Cheers,
Ben.

The following changes since commit 4a7cbb56fdbd92a47f57ca8b25bf5db35f0d6518:

  regulator: Fix documentation for of_node parameter of regulator_register() (2012-01-24 10:40:06 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (3):
      Merge remote-tracking branch 'kumar/merge' into merge
      powerpc/powernv: Fix PCI resource handling
      powerpc: Fix build on some non-freescale platforms

Christian Kujau (1):
      powerpc/crash: Fix build error without SMP

Deepthi Dharwar (1):
      powerpc/cpuidle: Make it a bool, not a tristate

Jerry Huang (1):
      powerpc/85xx: Fix cmd12 bug and add the chip compatible for eSDHC

Julia Lawall (1):
      arch/powerpc/sysdev/fsl_pci.c: add missing iounmap

Michael Neuling (1):
      powerpc: fix compile error with 85xx/p1022_ds.c

Ramneek Mehresh (2):
      powerpc/85xx: Enable USB2 controller node for P1020RDB
      powerpc/85xx: Add dr_mode property in USB nodes

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 +-
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    4 ++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 +-
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++
 arch/powerpc/boot/dts/p1020rdb.dtsi           |   13 +++----
 arch/powerpc/boot/dts/p1021mds.dts            |    3 +-
 arch/powerpc/boot/dts/p2020ds.dtsi            |    3 +-
 arch/powerpc/boot/dts/p2020rdb.dts            |    3 +-
 arch/powerpc/kernel/crash.c                   |    2 +-
 arch/powerpc/kernel/legacy_serial.c           |    2 +
 arch/powerpc/platforms/85xx/p1022_ds.c        |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c     |   43 +++++++++++++++---------
 arch/powerpc/platforms/pseries/Kconfig        |    2 +-
 arch/powerpc/sysdev/fsl_pci.c                 |    5 ++-
 15 files changed, 63 insertions(+), 32 deletions(-)
