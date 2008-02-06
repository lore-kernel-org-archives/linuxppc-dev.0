Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAE33DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 17:04:13 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m166481Z004170
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 00:04:09 -0600
Date: Wed, 6 Feb 2008 00:01:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: Please pull from 'for-2.6.25' (updated)
Message-ID: <Pine.LNX.4.64.0802060000520.6745@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.25' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.25

to receive the following updates:

(Found a few patches I missed.)

 arch/powerpc/boot/dts/adder875-redboot.dts      |    1
 arch/powerpc/boot/dts/adder875-uboot.dts        |    1
 arch/powerpc/boot/dts/mpc8313erdb.dts           |    4
 arch/powerpc/boot/dts/mpc8315erdb.dts           |    2
 arch/powerpc/boot/dts/mpc834x_mds.dts           |    2
 arch/powerpc/boot/dts/mpc8572ds.dts             |   12
 arch/powerpc/boot/dts/mpc885ads.dts             |    1
 arch/powerpc/boot/dts/storcenter.dts            |   12
 arch/powerpc/configs/mpc83xx_defconfig          |   10
 arch/powerpc/kernel/cputable.c                  |   10
 arch/powerpc/kernel/pmc.c                       |    2
 arch/powerpc/oprofile/Makefile                  |    2
 arch/powerpc/oprofile/common.c                  |    6
 arch/powerpc/oprofile/op_model_fsl_booke.c      |  371 ------------------------
 arch/powerpc/oprofile/op_model_fsl_emb.c        |  369 +++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc832x_rdb.c       |    2
 arch/powerpc/platforms/83xx/mpc83xx.h           |    2
 arch/powerpc/platforms/83xx/usb.c               |   17 -
 arch/powerpc/platforms/8xx/adder875.c           |    6
 arch/powerpc/platforms/8xx/ep88xc.c             |    1
 arch/powerpc/platforms/Kconfig                  |    1
 arch/powerpc/platforms/Kconfig.cputype          |    4
 arch/powerpc/platforms/embedded6xx/storcenter.c |   25 -
 arch/powerpc/sysdev/fsl_soc.c                   |    2
 arch/powerpc/sysdev/qe_lib/qe.c                 |   10
 drivers/net/Kconfig                             |    4
 drivers/net/cpmac.c                             |   55 +--
 include/asm-powerpc/cputable.h                  |    2
 include/asm-powerpc/oprofile_impl.h             |    2
 include/asm-powerpc/reg.h                       |    4
 include/asm-powerpc/reg_booke.h                 |   62 ----
 include/asm-powerpc/reg_fsl_emb.h               |   72 ++++
 32 files changed, 546 insertions(+), 530 deletions(-)

Andy Fleming (2):
      [POWERPC] Made FSL Book-E PMC support more generic
      [POWERPC} Add oprofile support for e300

Anton Vorontsov (2):
      cpmac: convert to new Fixed PHY infrastructure
      [POWERPC] qe_lib: fix few fluffy negligences

Bryan O'Donoghue (1):
      [POWERPC] 8xx: Add clock-frequency to adder875 and mpc885ads dts

Jon Loeliger (1):
      [POWERPC] Fix storcenter DTS typos, feedback, IRQs.

Kim Phillips (6):
      [POWERPC] 83xx: configure USB clock for MPC8315E
      [POWERPC] 83xx: Correct 2nd PCI controller interrupt value in mpc834x_mds dts
      [POWERPC] 83xx: Add rtc node to mpc8313erdb dts
      [POWERPC] 83xx: mpc832x_rdb: fix compiler warning
      [POWERPC] FSL: fix mpc83xx_spi device registration
      [POWERPC] 83xx: Update mpc83xx_defconfig

Kumar Gala (1):
      [POWERPC] 85xx: Add second cpu to 8572 dts

Scott Wood (1):
      [POWERPC] 8xx: adder875, ep88xc: fix to match recent 8xx cleanups.
