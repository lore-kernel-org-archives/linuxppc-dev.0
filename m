Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3A58D1007DD
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 16:03:37 +1100 (EST)
Date: Wed, 23 Nov 2011 23:03:31 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1111232302440.20012@right.am.freescale.net>
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

A few minor fixes for FSL PPC SoCs to send up to Linus.

- k

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      powerpc/85xx: Fix compile error on p3060_qds.c

Paul Bolle (1):
      powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'

Roy Zang (1):
      powerpc/p1023: set IRQ[4:6,11] to active-high level sensitive for PCIe

 arch/powerpc/boot/dts/p1023rds.dts      |   17 +++++++++++++----
 arch/powerpc/platforms/85xx/Kconfig     |    2 +-
 arch/powerpc/platforms/85xx/p3060_qds.c |    2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)
