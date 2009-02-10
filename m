Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD9AFDDDE0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 14:25:17 +1100 (EST)
Date: Mon, 9 Feb 2009 21:25:12 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch (updated)(for 2.6.29)
Message-ID: <Pine.LNX.4.64.0902092123490.29563@blarg.am.freescale.net>
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
 arch/powerpc/mm/fsl_booke_mmu.c                 |    4 ++--
 arch/powerpc/mm/pgtable_32.c                    |    4 ++--
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c    |    2 +-
 arch/powerpc/sysdev/cpm2_pic.c                  |    2 +-
 arch/powerpc/sysdev/ipic.c                      |    2 +-
 7 files changed, 12 insertions(+), 15 deletions(-)

Anton Vorontsov (2):
      powerpc/83xx: Fix missing #{address,size}-cells in mpc8313erdb.dts
      powerpc/83xx: Fix TSEC0 workability on MPC8313E-RDB boards

Julia Lawall (1):
      arch/powerpc: Eliminate double sizeof

Kumar Gala (1):
      powerpc/fsl-booke: Fix mapping functions to use phys_addr_t

Michael Neuling (1):
      powerpc/83xx: Build breakage for CONFIG_PM but no CONFIG_SUSPEND

paulfax (1):
      powerpc/cpm2: Fix set interrupt type

(added the one patch from me that fixes 36-bit physical support on
85xx/e500)

- k
