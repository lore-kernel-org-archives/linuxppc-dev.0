Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EA855B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 12:13:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2FD5ADDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 12:13:11 +1000 (EST)
Date: Tue, 25 Aug 2009 21:13:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from my 'next' branch
Message-ID: <Pine.LNX.4.64.0908252112490.16070@localhost.localdomain>
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

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/dts/mpc8272ads.dts        |    8
 arch/powerpc/boot/dts/mpc8536ds.dts         |    8
 arch/powerpc/boot/dts/mpc8536ds_36b.dts     |    8
 arch/powerpc/boot/dts/mpc8569mds.dts        |   45 ++
 arch/powerpc/boot/dts/p2020rdb.dts          |  586 ++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/sbc8349.dts           |   60 ++
 arch/powerpc/boot/dts/sbc8560.dts           |    1
 arch/powerpc/configs/83xx/sbc834x_defconfig |  320 ++++++++++++++-
 arch/powerpc/configs/mgcoge_defconfig       |   86 +++-
 arch/powerpc/configs/mpc85xx_defconfig      |    1
 arch/powerpc/include/asm/mmu-book3e.h       |   12
 arch/powerpc/include/asm/reg_booke.h        |    6
 arch/powerpc/mm/tlb_nohash_low.S            |    2
 arch/powerpc/platforms/82xx/mpc8272_ads.c   |   22 +
 arch/powerpc/platforms/85xx/Kconfig         |    9
 arch/powerpc/platforms/85xx/Makefile        |    3
 arch/powerpc/platforms/85xx/mpc85xx_mds.c   |    4
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c   |  141 ++++++
 arch/powerpc/platforms/85xx/sbc8560.c       |   39 +
 arch/powerpc/sysdev/fsl_soc.c               |    6
 arch/powerpc/sysdev/qe_lib/gpio.c           |    4
 21 files changed, 1321 insertions(+), 50 deletions(-)

Anton Vorontsov (4):
      powerpc/85xx: Add eSDHC support for MPC8536DS boards
      powerpc/82xx: Fix BCSR bits for MPC8272ADS boards
      powerpc/82xx: Add CPM USB Gadget support for MPC8272ADS boards
      powerpc/85xx: Add QE USB support for MPC8569E-MDS boards

Heiko Schocher (1):
      powerpc/82xx: mgcoge - updated defconfig

Kumar Gala (1):
      powerpc/booke: Move MMUCSR definition into mmu-book3e.h

Liang Li (4):
      powerpc/83xx: Remove second USB node from SBC834x DTS
      powerpc/83xx: Add localbus node and MTD partitions for SBC834x
      powerpc/83xx: Fix incorrect PCI interrupt map in SBC834x DTS
      powerpc/85xx: sbc8560 - Fix warm reboot with board specific reset function

Michael Barkowski (1):
      powerpc/qe_lib: Set gpio data before changing the direction to output

Paul Gortmaker (3):
      powerpc/83xx: sbc8349 - update defconfig, enable MTD, USB storage
      powerpc/85xx: issue fsl_soc reboot warning only when applicable
      powerpc/85xx: sbc8560 - remove "has-rstcr" from global utilities block

Poonam Aggrwal (1):
      powerpc/85xx: Add support for P2020RDB board
