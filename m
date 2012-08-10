Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 963492C0919
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2012 23:07:12 +1000 (EST)
Date: Fri, 10 Aug 2012 08:07:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
In-Reply-To: <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
Message-ID: <alpine.LFD.2.00.1208100806200.16855@right.am.freescale.net>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
 <1344033253.24037.70.camel@pasglop>
 <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Two updates from last week (one dts bug fix, one minor defconfig update)

- k

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

for you to fetch changes up to 09a3017a585eb8567a7de15b426bb1dfb548bf0f:

  powerpc/p4080ds: dts - add usb controller version info and port0 (2012-08-10 07:47:02 -0500)

----------------------------------------------------------------
Jia Hongtao (1):
      powerpc/fsl-pci: Only scan PCI bus if configured as a host

Shengzhou Liu (1):
      powerpc/p4080ds: dts - add usb controller version info and port0

Zhao Chenhui (1):
      powerpc/85xx: mpc85xx_defconfig - add VIA PATA support for MPC85xxCDS

 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    7 +++++++
 arch/powerpc/configs/mpc85xx_defconfig      |    1 +
 arch/powerpc/sysdev/fsl_pci.c               |   13 ++++++++-----
 3 files changed, 16 insertions(+), 5 deletions(-)
