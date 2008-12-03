Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D54F8DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 02:54:56 +1100 (EST)
Date: Wed, 3 Dec 2008 09:54:51 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0812030941550.29971@blarg.am.freescale.net>
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

 arch/powerpc/Makefile                          |    1
 arch/powerpc/boot/dts/gef_sbc610.dts           |   11
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    8
 arch/powerpc/include/asm/mmu-fsl-booke.h       |    2
 arch/powerpc/include/asm/processor.h           |    6
 arch/powerpc/include/asm/sfp-machine.h         |   58 +-
 arch/powerpc/kernel/head_fsl_booke.S           |  103 +++
 arch/powerpc/kernel/traps.c                    |   62 +-
 arch/powerpc/math-emu/Makefile                 |    2
 arch/powerpc/math-emu/fadd.c                   |    1
 arch/powerpc/math-emu/fcmpo.c                  |    5
 arch/powerpc/math-emu/fdiv.c                   |    9
 arch/powerpc/math-emu/fdivs.c                  |    9
 arch/powerpc/math-emu/fmadd.c                  |    5
 arch/powerpc/math-emu/fmadds.c                 |    5
 arch/powerpc/math-emu/fmsub.c                  |    5
 arch/powerpc/math-emu/fmsubs.c                 |    5
 arch/powerpc/math-emu/fmul.c                   |    3
 arch/powerpc/math-emu/fmuls.c                  |    3
 arch/powerpc/math-emu/fnmadd.c                 |    5
 arch/powerpc/math-emu/fnmadds.c                |    5
 arch/powerpc/math-emu/fnmsub.c                 |    5
 arch/powerpc/math-emu/fnmsubs.c                |    5
 arch/powerpc/math-emu/fsqrt.c                  |    5
 arch/powerpc/math-emu/fsqrts.c                 |    5
 arch/powerpc/math-emu/fsub.c                   |    3
 arch/powerpc/math-emu/fsubs.c                  |    3
 arch/powerpc/math-emu/math_efp.c               |  720 +++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Makefile           |    2
 arch/powerpc/platforms/85xx/mpc85xx_mds.c      |    4
 arch/powerpc/platforms/85xx/smp.c              |  104 +++
 arch/powerpc/platforms/86xx/Kconfig            |    2
 arch/powerpc/platforms/86xx/Makefile           |    3
 arch/powerpc/platforms/86xx/gef_gpio.c         |  143 ++++
 arch/powerpc/sysdev/qe_lib/qe.c                |    3
 arch/powerpc/sysdev/qe_lib/ucc.c               |    4
 36 files changed, 1225 insertions(+), 99 deletions(-)

Anton Vorontsov (1):
      powerpc/qe: Move cmxgcr_lock definition from the ucc.c into the qe.c

Kumar Gala (4):
      powerpc: Remove unncessary SPE related compiler flag
      powerpc/85xx: minor head_fsl_booke.S cleanup
      powerpc/85xx: Add support for SMP initialization
      powerpc/85xx: Fix compile warnings in mpc85xx_mds.c

Liu Yu (4):
      powerpc/math-emu: Fix single float point division bug
      powerpc/math-emu: Adopt new version of _FP_CHOOSENAN
      powerpc/math-emu: Remove redundant 'ret'
      powerpc: Add SPE/EFP math emulation for E500v1/v2 processors.

Martyn Welch (2):
      powerpc/86xx: Add use of Epson RTX-8581 RTC to GE Fanuc SBC610 dts
      powerpc/86xx: Basic GPIO support for GE Fanuc SBC610

Trent Piepho (1):
      powerpc: Better setup of boot page TLB entry
