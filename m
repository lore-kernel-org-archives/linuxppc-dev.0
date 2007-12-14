Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12B27DDF33
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 18:59:45 +1100 (EST)
Date: Fri, 14 Dec 2007 01:58:01 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branch
Message-ID: <Pine.LNX.4.64.0712140157340.14350@blarg.am.freescale.net>
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

 Documentation/powerpc/booting-without-of.txt |   19
 arch/powerpc/boot/dts/kuroboxHD.dts          |   16
 arch/powerpc/boot/dts/kuroboxHG.dts          |   16
 arch/powerpc/boot/dts/lite5200.dts           |    6
 arch/powerpc/boot/dts/lite5200b.dts          |    6
 arch/powerpc/boot/dts/mpc8313erdb.dts        |   36 -
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   45 -
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   47 -
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   54 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |   32
 arch/powerpc/boot/dts/mpc834x_mds.dts        |   51 -
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   47 -
 arch/powerpc/boot/dts/mpc8540ads.dts         |   59 -
 arch/powerpc/boot/dts/mpc8541cds.dts         |   41 -
 arch/powerpc/boot/dts/mpc8544ds.dts          |   59 +
 arch/powerpc/boot/dts/mpc8548cds.dts         |   68 +-
 arch/powerpc/boot/dts/mpc8555cds.dts         |   41 -
 arch/powerpc/boot/dts/mpc8560ads.dts         |   59 -
 arch/powerpc/boot/dts/mpc8568mds.dts         |   80 +-
 arch/powerpc/boot/dts/mpc8572ds.dts          |   59 +
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |   28
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |   80 +-
 arch/powerpc/boot/dts/mpc866ads.dts          |  156 ++--
 arch/powerpc/configs/mpc837x_mds_defconfig   |  878 +++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c               |   13
 arch/powerpc/kernel/traps.c                  |   25
 arch/powerpc/platforms/82xx/pq2fads.c        |    2
 arch/powerpc/platforms/83xx/Kconfig          |   11
 arch/powerpc/platforms/83xx/Makefile         |    1
 arch/powerpc/platforms/83xx/mpc8313_rdb.c    |    4
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    4
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |    2
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |   21
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |    4
 arch/powerpc/platforms/83xx/mpc837x_mds.c    |  104 +++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    4
 arch/powerpc/platforms/8xx/Kconfig           |    1
 arch/powerpc/platforms/8xx/mpc86xads.h       |   44 -
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |  289 ++------
 arch/powerpc/sysdev/commproc.c               |   47 +
 arch/powerpc/sysdev/cpm2_common.c            |   25
 arch/powerpc/sysdev/fsl_soc.c                |   23
 arch/powerpc/sysdev/ipic.c                   |  219 ++++--
 arch/powerpc/sysdev/ipic.h                   |   13
 arch/powerpc/sysdev/qe_lib/qe.c              |   46 +
 drivers/net/fs_enet/mac-fcc.c                |   10
 drivers/net/fs_enet/mac-scc.c                |   11
 drivers/net/ucc_geth.c                       |   55 +
 drivers/serial/cpm_uart/cpm_uart_cpm1.c      |    6
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    8
 include/asm-powerpc/cpm.h                    |    1
 include/asm-powerpc/immap_86xx.h             |   25
 include/asm-powerpc/ipic.h                   |   12
 include/asm-powerpc/qe.h                     |   95 +-
 include/asm-powerpc/reg_booke.h              |   13
 55 files changed, 2214 insertions(+), 907 deletions(-)

Jochen Friedrich (2):
      [POWERPC] Add support for PORTA and PORTB odr registers
      [POWERPC] Move CPM command handling into the cpm drivers

Jon Loeliger (2):
      [POWERPC] 8xxx: Convert #include of asm/of_{platform, device}.h into linux/of_{platform, device}.h.
      [POWERPC] 86xx: Add aliases node to 8641hpcn DTS file.

Kumar Gala (5):
      [POWERPC] Add SPRN for Embedded registers specified in PowerISA 2.04
      [POWERPC] Emulate isel (Integer Select) instruction
      [POWERPC] FSL: I2C device tree cleanups
      [POWERPC] FSL: enet device tree cleanups
      [POWERPC] FSL: Added aliases node to device trees

Li Yang (5):
      [POWERPC] add e300c4 entry to cputable
      [POWERPC] ipic: add new interrupts introduced by new chip
      [POWERPC] 83xx: Add platform support for MPC837x MDS board
      [POWERPC] 83xx: Add MPC837x MDS default kernel configuration
      [POWERPC] ipic: ack only for edge interrupts

Scott Wood (3):
      [POWERPC] 8xx: Convert mpc866ads to the new device binding.
      [POWERPC] 83xx: mpc834x_mds: Fix whitespace and call of_platform_bus_probe().
      [POWERPC] 83xx: mpc8313erdb: Fix whitespace.

Timur Tabi (4):
      [POWERPC] 86xx: fix guts_set_dmacr() and add guts_set_pmuxcr_dma() to immap_86xx.h
      [POWERPC] QE: change qe_setbrg() to take an enum qe_clock instead of an integer
      [POWERPC] qe: add function qe_clock_source()
      [POWERPC] ucc_geth: use rx-clock-name and tx-clock-name device tree properties
