Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0AF82B701F
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2012 10:05:23 +1000 (EST)
Date: Thu, 19 Apr 2012 19:05:17 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.02.1204191904290.11272@spiff>
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

Some bug fix patches for v3.4.

- k

The following changes since commit fae2e0fb24c61ca68c98d854a34732549ebc1854:

  powerpc: Fix typo in runlatch code (2012-04-11 10:42:15 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Baruch Siach (1):
      powerpc: fix build when CONFIG_BOOKE_WDT is enabled

Mingkai Hu (4):
      powerpc/mpic_msgr: fix compile error when SMP disabled
      powerpc/mpic_msgr: add lock for MPIC message global variable
      powerpc/mpic_msgr: fix offset error when setting mer register
      powerpc/mpc85xx: add MPIC message dts node

Timur Tabi (1):
      powerpc/85xx: don't call of_platform_bus_probe() twice

 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi |   43 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi           |   10 +++++
 arch/powerpc/include/asm/mpic_msgr.h              |    1 +
 arch/powerpc/include/asm/reg_booke.h              |    5 --
 arch/powerpc/kernel/setup_32.c                    |    3 +
 arch/powerpc/platforms/85xx/common.c              |    6 +++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   11 +-----
 arch/powerpc/platforms/85xx/p1022_ds.c            |   13 +------
 arch/powerpc/sysdev/mpic_msgr.c                   |   12 +++---
 9 files changed, 71 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
