Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 13C8FB6EFF
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 09:29:53 +1100 (EST)
Date: Tue, 17 Jan 2012 16:26:17 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1201171625100.8416@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Pulled in a few other minor fixes, in addition the the compile issue on
p1022.

- k

The following changes since commit c2bc3a316a7281f67e36b34dac2802cbe36a9128:

  Merge branch 'x86/rdrand' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2012-01-16 18:23:09 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Jerry Huang (1):
      powerpc/85xx: Fix cmd12 bug and add the chip compatible for eSDHC

Julia Lawall (1):
      arch/powerpc/sysdev/fsl_pci.c: add missing iounmap

Michael Neuling (1):
      powerpc: fix compile error with 85xx/p1022_ds.c

Zhicheng Fan (1):
      powerpc/85xx: Fix minor issues in P1020RDB device tree

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    3 +++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
 arch/powerpc/boot/dts/p1020rdb.dts            |    2 +-
 arch/powerpc/boot/dts/p1020rdb_36b.dts        |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c        |    1 +
 arch/powerpc/sysdev/fsl_pci.c                 |    5 +++--
 9 files changed, 21 insertions(+), 6 deletions(-)
