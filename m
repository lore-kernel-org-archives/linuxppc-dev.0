Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68F40DE45B
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 22:41:46 +1000 (EST)
Date: Thu, 21 Aug 2008 07:41:40 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.27' (updated)
Message-ID: <Pine.LNX.4.64.0808210740500.6958@blarg.am.freescale.net>
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

Please pull from 'for-2.6.27' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.27

to receive the following updates:

This is bug fixes and defconfig updates.  I dropped the Kconfig cpm serial
patch for 2.6.27 since its not really a bug fix and put it into my
powerpc-next branch for .28.  (I also moved 2 defconfigs since we were
already touching them).

- k

 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |    2
 arch/powerpc/boot/dts/tqm8548-bigflash.dts        |    8
 arch/powerpc/boot/dts/tqm8548.dts                 |    3
 arch/powerpc/boot/wrapper                         |    2
 arch/powerpc/configs/83xx/asp8347_defconfig       | 1334 +++++++++++++++++
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  188 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  188 +-
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  172 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  176 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  175 +-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  172 +-
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  168 +-
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  172 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  183 +-
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  351 ++++
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  340 ++++
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  239 ++-
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   95 -
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig    | 1654 ++++++++++++++++++++++
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   71
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |  178 +-
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   98 -
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |  121 +
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |  177 +-
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   85 -
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   63
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   69
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  163 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig       |  112 +
 arch/powerpc/configs/85xx/tqm8541_defconfig       |  139 +
 arch/powerpc/configs/85xx/tqm8548_defconfig       |  129 +
 arch/powerpc/configs/85xx/tqm8555_defconfig       |  139 +
 arch/powerpc/configs/85xx/tqm8560_defconfig       |  139 +
 arch/powerpc/configs/adder875_defconfig           |   55
 arch/powerpc/configs/asp8347_defconfig            | 1214 ----------------
 arch/powerpc/configs/c2k_defconfig                |  245 +--
 arch/powerpc/configs/ep8248e_defconfig            |  198 ++
 arch/powerpc/configs/ep88xc_defconfig             |   57
 arch/powerpc/configs/linkstation_defconfig        |  133 +
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   72
 arch/powerpc/configs/mpc8272_ads_defconfig        |  132 +
 arch/powerpc/configs/mpc83xx_defconfig            |  389 ++++-
 arch/powerpc/configs/mpc8536_ds_defconfig         | 1637 ---------------------
 arch/powerpc/configs/mpc85xx_defconfig            |  207 +-
 arch/powerpc/configs/mpc8610_hpcd_defconfig       |  165 +-
 arch/powerpc/configs/mpc8641_hpcn_defconfig       |  215 +-
 arch/powerpc/configs/mpc866_ads_defconfig         |   61
 arch/powerpc/configs/mpc885_ads_defconfig         |   57
 arch/powerpc/configs/pq2fads_defconfig            |  147 +
 arch/powerpc/configs/prpmc2800_defconfig          |  125 +
 arch/powerpc/configs/sbc8641d_defconfig           |  173 +-
 arch/powerpc/configs/storcenter_defconfig         |  113 +
 arch/powerpc/sysdev/cpm_common.c                  |   37
 arch/powerpc/sysdev/qe_lib/ucc_fast.c             |    4
 arch/powerpc/sysdev/qe_lib/ucc_slow.c             |    8
 55 files changed, 8093 insertions(+), 4656 deletions(-)

Kumar Gala (2):
      powerpc: Fix whitespace merge in mpc8641 hpcn device tree
      powerpc: Update defconfigs for FSL PPC boards

Laurent Pinchart (1):
      cpm2: Fix race condition in CPM2 GPIO library.

Scott Wood (1):
      powerpc: Add cuImage.mpc866ads to the bootwrapper as a cuboot-8xx target

Timur Tabi (1):
      powerpc: fix memory leaks in QE library

Wolfgang Grandegger (1):
      powerpc/85xx: TQM8548: DTS file fixes and cleanup
