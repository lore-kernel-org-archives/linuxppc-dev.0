Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 352E2DE017
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:33:41 +1000 (EST)
Date: Wed, 13 May 2009 17:33:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0905131732520.781@localhost.localdomain>
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

This is based on v2.6.30-rc5.

- k

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 Documentation/powerpc/dts-bindings/ecm.txt           |   64 +
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt |    3
 Documentation/powerpc/dts-bindings/fsl/mcm.txt       |   64 +
 arch/powerpc/boot/dts/gef_ppc9a.dts                  |   14
 arch/powerpc/boot/dts/gef_sbc310.dts                 |   14
 arch/powerpc/boot/dts/gef_sbc610.dts                 |   14
 arch/powerpc/boot/dts/ksi8560.dts                    |   13
 arch/powerpc/boot/dts/mpc832x_mds.dts                |    3
 arch/powerpc/boot/dts/mpc832x_rdb.dts                |    3
 arch/powerpc/boot/dts/mpc8349emitx.dts               |    2
 arch/powerpc/boot/dts/mpc8349emitxgp.dts             |    1
 arch/powerpc/boot/dts/mpc834x_mds.dts                |    2
 arch/powerpc/boot/dts/mpc836x_mds.dts                |    3
 arch/powerpc/boot/dts/mpc836x_rdk.dts                |    2
 arch/powerpc/boot/dts/mpc8377_mds.dts                |    1
 arch/powerpc/boot/dts/mpc8378_mds.dts                |    1
 arch/powerpc/boot/dts/mpc8379_mds.dts                |    1
 arch/powerpc/boot/dts/mpc8536ds.dts                  |   18
 arch/powerpc/boot/dts/mpc8540ads.dts                 |   15
 arch/powerpc/boot/dts/mpc8541cds.dts                 |   16
 arch/powerpc/boot/dts/mpc8544ds.dts                  |   18
 arch/powerpc/boot/dts/mpc8548cds.dts                 |   17
 arch/powerpc/boot/dts/mpc8555cds.dts                 |   16
 arch/powerpc/boot/dts/mpc8560ads.dts                 |   15
 arch/powerpc/boot/dts/mpc8568mds.dts                 |   51 +
 arch/powerpc/boot/dts/mpc8569mds.dts                 |  583 ++++++++++++++++++
 arch/powerpc/boot/dts/mpc8572ds.dts                  |   17
 arch/powerpc/boot/dts/mpc8572ds_36b.dts              |   39 -
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts       |   16
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts       |    2
 arch/powerpc/boot/dts/mpc8610_hpcd.dts               |   16
 arch/powerpc/boot/dts/mpc8641_hpcn.dts               |   16
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts           |  609 +++++++++++++++++++
 arch/powerpc/boot/dts/sbc8349.dts                    |    1
 arch/powerpc/boot/dts/sbc8548.dts                    |   16
 arch/powerpc/boot/dts/sbc8560.dts                    |   15
 arch/powerpc/boot/dts/sbc8641d.dts                   |   16
 arch/powerpc/boot/dts/socrates.dts                   |   15
 arch/powerpc/boot/dts/stx_gp3_8560.dts               |   15
 arch/powerpc/boot/dts/tqm8540.dts                    |   15
 arch/powerpc/boot/dts/tqm8541.dts                    |   15
 arch/powerpc/boot/dts/tqm8548-bigflash.dts           |   16
 arch/powerpc/boot/dts/tqm8548.dts                    |   16
 arch/powerpc/boot/dts/tqm8555.dts                    |   15
 arch/powerpc/boot/dts/tqm8560.dts                    |   15
 arch/powerpc/include/asm/cpm1.h                      |    2
 arch/powerpc/include/asm/cpm2.h                      |    4
 arch/powerpc/include/asm/mpc86xx.h                   |   33 -
 arch/powerpc/include/asm/pci-bridge.h                |    6
 arch/powerpc/include/asm/qe.h                        |   21
 arch/powerpc/oprofile/op_model_fsl_emb.c             |   14
 arch/powerpc/platforms/82xx/pq2ads.h                 |   13
 arch/powerpc/platforms/85xx/Kconfig                  |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c            |   52 +
 arch/powerpc/platforms/86xx/gef_ppc9a.c              |    1
 arch/powerpc/platforms/86xx/gef_sbc310.c             |    1
 arch/powerpc/platforms/86xx/gef_sbc610.c             |    1
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c           |    1
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c           |    1
 arch/powerpc/platforms/86xx/mpc86xx_smp.c            |    8
 arch/powerpc/platforms/86xx/sbc8641d.c               |    1
 arch/powerpc/platforms/8xx/mpc885ads.h               |    4
 arch/powerpc/platforms/fsl_uli1575.c                 |   23
 arch/powerpc/sysdev/cpm2.c                           |    2
 arch/powerpc/sysdev/fsl_msi.c                        |    9
 arch/powerpc/sysdev/fsl_pci.c                        |    6
 arch/powerpc/sysdev/fsl_rio.c                        |   15
 arch/powerpc/sysdev/fsl_soc.c                        |   14
 arch/powerpc/sysdev/qe_lib/qe.c                      |   75 ++
 drivers/dma/fsldma.c                                 |   13
 drivers/net/ucc_geth.c                               |   24
 drivers/net/ucc_geth.h                               |    4
 drivers/of/base.c                                    |    1
 drivers/rapidio/rio-scan.c                           |    6
 include/linux/pci_ids.h                              |    2
 75 files changed, 1949 insertions(+), 248 deletions(-)

Anton Vorontsov (6):
      powerpc/85xx: Add PCI IDs for MPC8569 family processors
      powerpc/85xx: Fix mpc8569emds crypto node to include SNOW unit
      powerpc/85xx: Fix reg & interrupts for mpc8569emds localbus added NAND
      powerpc/85xx: Add eSDHC support for MPC8569E-MDS boards
      powerpc/85xx: Enable Serial RapidIO for MPC85xx MDS boards
      powerpc/85xx: Add STMicro M25P40 serial flash support for MPC8569E-MDS

Becky Bruce (2):
      powerpc/86xx: Add 36-bit device tree for mpc8641hpcn
      powerpc: make dma_window_* in pci_controller struct avail on 32b

Haiying Wang (7):
      powerpc/85xx: clean up for mpc8568_mds name
      powerpc/qe: update risc allocation for QE
      net/ucc_geth: update riscTx and riscRx in ucc_geth
      powerpc/qe: update QE Serial Number
      net/ucc_geth: Assign six threads to Rx for UEC
      powerpc/85xx: Add MPC8569MDS board support
      powerpc/qe: add new qe properties for QE based chips

Kumar Gala (15):
      powerpc/fsl: Remove cell-index from PCI nodes
      powerpc: Refactor board check for PCI quirks on FSL boards with uli1575
      powerpc/fsl: use of_iomap() for rstcr mapping
      powerpc/85xx: Add binding for LAWs and ECM
      powerpc/85xx: Add new LAW & ECM device tree nodes for all 85xx systems
      powerpc/86xx: Add binding for LAWs and MCM
      powerpc/86xx: Add new LAW & MCM device tree nodes for all 86xx systems
      powerpc/cpm: Remove some cruft code and defines
      powerpc/86xx: clean up smp init code
      powerpc/fsl: Removed reg property from 85xx/86xx soc node
      fsldma: Fix compile warnings
      powerpc/85xx: Add MSI nodes for MPC8568/9 MDS systems
      powerpc/fsl: Support unique MSI addresses per PCIe Root Complex
      powerpc/8xxx: Update PCI outbound window addresses for 36-bit configs
      powerpc/fsl_rio: Fix compile warnings

Li Yang (2):
      powerpc/fsl_rio: use LAW address from device tree
      rapidio: fix section mismatch warnings

Michael Ellerman (1):
      powerpc/oprofile: Remove unused dump_pmcs() in FSL oprofile
