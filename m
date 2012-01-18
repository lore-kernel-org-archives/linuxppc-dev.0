Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9564F1007D1
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2012 01:29:11 +1100 (EST)
Date: Wed, 18 Jan 2012 08:25:32 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
In-Reply-To: <alpine.LFD.2.00.1201171625100.8416@right.am.freescale.net>
Message-ID: <alpine.LFD.2.00.1201180824500.6644@right.am.freescale.net>
References: <alpine.LFD.2.00.1201171625100.8416@right.am.freescale.net>
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

Dropped the P1020RDB device tree patch as it was for the wrong board
revision and pulled in some additional usb device tree fixes.

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

Ramneek Mehresh (2):
      powerpc/85xx: Enable USB2 controller node for P1020RDB
      powerpc/85xx: Add dr_mode property in USB nodes

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    4 ++++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
 arch/powerpc/boot/dts/p1020rdb.dtsi           |   13 ++++++-------
 arch/powerpc/boot/dts/p1021mds.dts            |    3 ++-
 arch/powerpc/boot/dts/p2020ds.dtsi            |    3 ++-
 arch/powerpc/boot/dts/p2020rdb.dts            |    3 ++-
 arch/powerpc/platforms/85xx/p1022_ds.c        |    1 +
 arch/powerpc/sysdev/fsl_pci.c                 |    5 +++--
 11 files changed, 32 insertions(+), 14 deletions(-)
