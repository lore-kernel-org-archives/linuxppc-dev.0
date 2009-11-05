Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF1CFB7B65
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:24:14 +1100 (EST)
Date: Thu, 5 Nov 2009 07:24:06 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch for 2.6.32
Message-ID: <Pine.LNX.4.64.0911050723300.2779@localhost.localdomain>
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

The following changes since commit 38634e6769920929385f1ffc8820dc3e893cc630:
  Benjamin Herrenschmidt (1):
        powerpc/kvm: Remove problematic BUILD_BUG_ON statement

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

Anton Vorontsov (2):
      powerpc/85xx: Fix USB GPIOs for MPC8569E-MDS boards
      powerpc/83xx: Fix u-boot partion size for MPC8377E-WLAN boards

Paul Gortmaker (1):
      powerpc/85xx: sbc8548 - fixup of PCI-e related DTS fields

Roel Kluin (1):
      powerpc/82xx: kmalloc failure ignored in ep8248e_mdio_probe()

 arch/powerpc/boot/dts/mpc8377_wlan.dts |    2 +-
 arch/powerpc/boot/dts/mpc8569mds.dts   |    4 ++--
 arch/powerpc/boot/dts/sbc8548.dts      |   17 ++++++++---------
 arch/powerpc/platforms/82xx/ep8248e.c  |   15 ++++++++++++++-
 4 files changed, 25 insertions(+), 13 deletions(-)
