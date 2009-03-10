Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21F08DE050
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 06:00:57 +1100 (EST)
Date: Tue, 10 Mar 2009 14:00:47 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0903101359130.25312@blarg.am.freescale.net>
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

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

(The i2c patch was ack'd by Ben Dooks & cpm_uart has historically gone via
powerpc tree as a PPC specific driver).

 Documentation/powerpc/dts-bindings/fsl/ssi.txt |    2 +
 arch/powerpc/boot/dts/gef_sbc610.dts           |    2 -
 arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    2 +
 arch/powerpc/include/asm/mmu.h                 |    4 +-
 arch/powerpc/kernel/cputable.c                 |    3 +
 arch/powerpc/mm/tlb_nohash_low.S               |   44 +++++++++++++++++++++----
 arch/powerpc/platforms/83xx/usb.c              |    3 +
 arch/powerpc/sysdev/fsl_soc.c                  |    4 ++
 arch/powerpc/sysdev/ipic.c                     |    6 +--
 drivers/i2c/busses/i2c-mpc.c                   |    9 +----
 drivers/serial/cpm_uart/cpm_uart_core.c        |   14 ++++++-
 11 files changed, 69 insertions(+), 24 deletions(-)

Anton Vorontsov (1):
      powerpc/83xx: Do not configure or probe disabled FSL DR USB controllers

Da Yu (1):
      powerpc/83xx: Fix the interrupt loss problem on ipic

Kumar Gala (1):
      powerpc/fsl-booke: Add support for tlbilx instructions

Martyn Welch (1):
      powerpc/86xx: Correct local bus registers in GE Fanuc SBC610 dts file

Timur Tabi (2):
      i2c-mpc: do not allow interruptions when waiting for I2C to complete
      powerpc: add fsl,fifo-depth property to Freescale SSI device nodes

Xiaotian Feng (1):
      cpm_uart: fix non-console port startup bug
