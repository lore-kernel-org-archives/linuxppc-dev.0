Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5A60DE0CE
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:52:00 +1100 (EST)
Date: Fri, 6 Feb 2009 10:51:54 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch (for 2.6.29)
Message-ID: <Pine.LNX.4.64.0902061051330.378@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/mpc8313erdb.dts           |   11 ++++-------
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig |    2 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                  |    2 +-
 arch/powerpc/sysdev/ipic.c                      |    2 +-
 5 files changed, 8 insertions(+), 11 deletions(-)

Anton Vorontsov (2):
      powerpc/83xx: Fix missing #{address,size}-cells in mpc8313erdb.dts
      powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB boards

Julia Lawall (1):
      arch/powerpc: Eliminate double sizeof

Michael Neuling (1):
      powerpc/83xx: Build breakage for CONFIG_PM but no CONFIG_SUSPEND

paulfax (1):
      powerpc/cpm2: Fix set interrupt type
