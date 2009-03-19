Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93B63DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 20:05:35 +1100 (EST)
Date: Thu, 19 Mar 2009 04:05:30 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0903190405070.18895@blarg.am.freescale.net>
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

 arch/powerpc/Makefile                          |    4
 arch/powerpc/boot/dts/gef_ppc9a.dts            |  364 ++++
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig  | 1889 +++++++++++++++++++++++++
 arch/powerpc/math-emu/Makefile                 |    5
 arch/powerpc/platforms/85xx/ksi8560.c          |    2
 arch/powerpc/platforms/85xx/smp.c              |   43
 arch/powerpc/platforms/86xx/Kconfig            |   10
 arch/powerpc/platforms/86xx/Makefile           |    1
 arch/powerpc/platforms/86xx/gef_ppc9a.c        |  223 ++
 arch/powerpc/platforms/86xx/gef_sbc310.c       |    4
 arch/powerpc/sysdev/cpm2.c                     |    1
 drivers/watchdog/Kconfig                       |    2
 14 files changed, 2533 insertions(+), 19 deletions(-)

Grant Likely (1):
      powerpc/cpm2: fix building fs_enet driver as a module.

Kumar Gala (1):
      powerpc/85xx: Update smp support to handle doorbells and non-mpic init

Liu Yu (1):
      powerpc/math-emu: Fix efp dependence

Martyn Welch (3):
      powerpc/86xx: Run sbc310 USB fixup code only on the appropriate platform.
      powerpc/86xx: Board support for GE Fanuc's PPC9A
      powerpc/86xx: Default configuration for GE Fanuc's PPC9A

Ted Peters (1):
      powerpc/85xx: Fix MPC8572DS PCI protected interrupt sources

Thomas Gleixner (1):
      powerpc/85xx: remove setup_irq(NULL action) in ksi8560
