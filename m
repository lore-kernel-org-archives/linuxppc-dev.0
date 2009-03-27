Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D81C2DDE25
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 09:43:49 +1100 (EST)
Date: Fri, 27 Mar 2009 17:43:42 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0903271743140.4997@blarg.am.freescale.net>
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

 Documentation/powerpc/dts-bindings/fsl/ssi.txt  |   68 -
 arch/powerpc/boot/dts/asp834x-redboot.dts       |   82 -
 arch/powerpc/boot/dts/gef_ppc9a.dts             |   39
 arch/powerpc/boot/dts/gef_sbc310.dts            |   39
 arch/powerpc/boot/dts/gef_sbc610.dts            |   39
 arch/powerpc/boot/dts/ksi8560.dts               |   79 -
 arch/powerpc/boot/dts/mpc8313erdb.dts           |   11
 arch/powerpc/boot/dts/mpc8315erdb.dts           |   80 -
 arch/powerpc/boot/dts/mpc8349emitx.dts          |   69 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts        |   42
 arch/powerpc/boot/dts/mpc834x_mds.dts           |   81 -
 arch/powerpc/boot/dts/mpc8377_mds.dts           |  148 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts           |  165 +-
 arch/powerpc/boot/dts/mpc8378_mds.dts           |  146 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts           |  165 +-
 arch/powerpc/boot/dts/mpc8379_mds.dts           |  147 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts           |  164 +-
 arch/powerpc/boot/dts/mpc8536ds.dts             |   78 -
 arch/powerpc/boot/dts/mpc8540ads.dts            |  117 +
 arch/powerpc/boot/dts/mpc8541cds.dts            |   78 -
 arch/powerpc/boot/dts/mpc8544ds.dts             |   81 -
 arch/powerpc/boot/dts/mpc8548cds.dts            |  156 +-
 arch/powerpc/boot/dts/mpc8555cds.dts            |   78 -
 arch/powerpc/boot/dts/mpc8560ads.dts            |  102 -
 arch/powerpc/boot/dts/mpc8568mds.dts            |  102 -
 arch/powerpc/boot/dts/mpc8572ds.dts             |  150 +-
 arch/powerpc/boot/dts/mpc8572ds_36b.dts         |  150 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts  |   39
 arch/powerpc/boot/dts/mpc8641_hpcn.dts          |  157 +-
 arch/powerpc/boot/dts/sbc8349.dts               |   80 -
 arch/powerpc/boot/dts/sbc8548.dts               |   78 -
 arch/powerpc/boot/dts/sbc8560.dts               |  100 -
 arch/powerpc/boot/dts/sbc8641d.dts              |  156 +-
 arch/powerpc/boot/dts/socrates.dts              |  338 +++++
 arch/powerpc/boot/dts/stx_gp3_8560.dts          |   78 -
 arch/powerpc/boot/dts/tqm8540.dts               |  117 +
 arch/powerpc/boot/dts/tqm8541.dts               |   90 -
 arch/powerpc/boot/dts/tqm8548-bigflash.dts      |  168 +-
 arch/powerpc/boot/dts/tqm8548.dts               |  168 +-
 arch/powerpc/boot/dts/tqm8555.dts               |   90 -
 arch/powerpc/boot/dts/tqm8560.dts               |   90 -
 arch/powerpc/configs/85xx/socrates_defconfig    | 1410 ++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/asp834x.c           |    1
 arch/powerpc/platforms/83xx/mpc834x_itx.c       |    1
 arch/powerpc/platforms/83xx/mpc834x_mds.c       |    1
 arch/powerpc/platforms/83xx/mpc837x_mds.c       |    1
 arch/powerpc/platforms/83xx/mpc837x_rdb.c       |    1
 arch/powerpc/platforms/83xx/sbc834x.c           |    1
 arch/powerpc/platforms/85xx/Kconfig             |    6
 arch/powerpc/platforms/85xx/Makefile            |    1
 arch/powerpc/platforms/85xx/ksi8560.c           |    1
 arch/powerpc/platforms/85xx/mpc8536_ds.c        |    1
 arch/powerpc/platforms/85xx/mpc85xx_ads.c       |    1
 arch/powerpc/platforms/85xx/mpc85xx_cds.c       |    1
 arch/powerpc/platforms/85xx/mpc85xx_ds.c        |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c       |    1
 arch/powerpc/platforms/85xx/sbc8548.c           |    1
 arch/powerpc/platforms/85xx/sbc8560.c           |    1
 arch/powerpc/platforms/85xx/socrates.c          |  133 ++
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c |  327 +++++
 arch/powerpc/platforms/85xx/socrates_fpga_pic.h |   16
 arch/powerpc/platforms/85xx/stx_gp3.c           |    1
 arch/powerpc/platforms/85xx/tqm85xx.c           |    1
 arch/powerpc/platforms/86xx/gef_ppc9a.c         |    1
 arch/powerpc/platforms/86xx/gef_sbc310.c        |    1
 arch/powerpc/platforms/86xx/gef_sbc610.c        |    1
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c      |    1
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c      |    1
 arch/powerpc/platforms/86xx/sbc8641d.c          |    1
 69 files changed, 4507 insertions(+), 1813 deletions(-)

Anton Vorontsov (4):
      powerpc/83xx: Add power management support for MPC837x boards
      powerpc/83xx: Move gianfar mdio nodes under the ethernet nodes
      powerpc/85xx: Move gianfar mdio nodes under the ethernet nodes
      powerpc/86xx: Move gianfar mdio nodes under the ethernet nodes

Kumar Gala (1):
      powerpc/83xx: Update ranges in gianfar node to match other dts

Timur Tabi (1):
      powerpc: clean up ssi.txt, add definition for fsl,ssi-asynchronous

Wolfgang Grandegger (1):
      powerpc/85xx: Add support for the "socrates" board (MPC8544).
