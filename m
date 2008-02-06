Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 481EFDDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 16:48:16 +1100 (EST)
Date: Tue, 5 Feb 2008 23:45:37 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branchc
Message-ID: <Pine.LNX.4.64.0802052345010.6087@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
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

(based on a recent pull of linus's tree)

 arch/powerpc/boot/dts/adder875-redboot.dts      |    1
 arch/powerpc/boot/dts/adder875-uboot.dts        |    1
 arch/powerpc/boot/dts/mpc8313erdb.dts           |    4
 arch/powerpc/boot/dts/mpc8315erdb.dts           |    2
 arch/powerpc/boot/dts/mpc834x_mds.dts           |    2
 arch/powerpc/boot/dts/mpc885ads.dts             |    1
 arch/powerpc/boot/dts/storcenter.dts            |   12
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
 drivers/net/Kconfig                             |    4
 drivers/net/cpmac.c                             |   55 +--
 include/asm-powerpc/cputable.h                  |    2
 include/asm-powerpc/oprofile_impl.h             |    2
 include/asm-powerpc/reg.h                       |    4
 include/asm-powerpc/reg_booke.h                 |   62 ----
 include/asm-powerpc/reg_fsl_emb.h               |   72 ++++
 29 files changed, 524 insertions(+), 520 deletions(-)

Andy Fleming (2):
      [POWERPC] Made FSL Book-E PMC support more generic
      [POWERPC} Add oprofile support for e300

Anton Vorontsov (1):
      cpmac: convert to new Fixed PHY infrastructure

Bryan O'Donoghue (1):
      [POWERPC] 8xx: Add clock-frequency to adder875 and mpc885ads dts

Jon Loeliger (1):
      [POWERPC] Fix storcenter DTS typos, feedback, IRQs.

Kim Phillips (5):
      [POWERPC] 83xx: configure USB clock for MPC8315E
      [POWERPC] 83xx: Correct 2nd PCI controller interrupt value in mpc834x_mds dts
      [POWERPC] 83xx: Add rtc node to mpc8313erdb dts
      [POWERPC] 83xx: mpc832x_rdb: fix compiler warning
      [POWERPC] FSL: fix mpc83xx_spi device registration

Scott Wood (1):
      [POWERPC] 8xx: adder875, ep88xc: fix to match recent 8xx cleanups.
