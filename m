Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7813D1007D8
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 19:36:19 +1100 (EST)
Date: Thu, 24 Nov 2011 02:36:10 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
In-Reply-To: <6E4772AD-8272-4A7D-8262-88C385CE9619@kernel.crashing.org>
Message-ID: <alpine.LFD.2.00.1111240235220.16632@right.am.freescale.net>
References: <alpine.LFD.2.00.1111232302440.20012@right.am.freescale.net>
 <6E4772AD-8272-4A7D-8262-88C385CE9619@kernel.crashing.org>
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

Pulled in a bunch of other minor fixes that have been sitting around for a
while.

- k

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Alexandre Rusev (1):
      powerpc/fsl-lbc: Fix for fsl_upm

Joakim Tjernlund (1):
      powerpc/qe: Fixup QE_General4 errata

Julia Lawall (1):
      arch/powerpc/sysdev/ehv_pic.c: add missing kfree

Kumar Gala (1):
      powerpc/85xx: Fix compile error on p3060_qds.c

Paul Bolle (1):
      powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'

Roy Zang (1):
      powerpc/p1023: set IRQ[4:6,11] to active-high level sensitive for PCIe

Shaohui Xie (1):
      drivers/edac/mpc85xx_edac.c: fix memory controller compatible for edac

 arch/powerpc/boot/dts/p1023rds.dts      |   17 +++++++++++++----
 arch/powerpc/platforms/85xx/Kconfig     |    2 +-
 arch/powerpc/platforms/85xx/p3060_qds.c |    2 +-
 arch/powerpc/sysdev/ehv_pic.c           |    1 +
 arch/powerpc/sysdev/fsl_lbc.c           |    1 +
 arch/powerpc/sysdev/qe_lib/qe.c         |    2 +-
 drivers/edac/mpc85xx_edac.c             |    2 +-
 7 files changed, 19 insertions(+), 8 deletions(-)
