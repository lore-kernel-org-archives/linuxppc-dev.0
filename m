Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9866DDDE3
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 05:44:50 +1100 (EST)
Date: Sat, 8 Nov 2008 12:44:45 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' branch (for 2.6.28)
Message-ID: <Pine.LNX.4.64.0811081242540.3455@blarg.am.freescale.net>
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

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/gef_sbc610.dts              |    2
 arch/powerpc/configs/83xx/asp8347_defconfig       |  121 +++++----
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  158 +++++++-----
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  158 +++++++-----
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  125 +++++----
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  136 ++++++----
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  171 +++++++++----
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  121 +++++----
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  123 +++++----
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  126 +++++----
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  119 +++++----
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  123 +++++----
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  155 +++++++-----
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  119 +++++----
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   87 ++++--
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   74 ++++-
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   90 +++++--
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |   93 +++++--
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   91 +++++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   75 ++++-
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   78 ++++--
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  115 ++++++---
 arch/powerpc/configs/85xx/tqm8540_defconfig       |   91 +++++--
 arch/powerpc/configs/85xx/tqm8541_defconfig       |   96 +++++--
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   98 +++++--
 arch/powerpc/configs/85xx/tqm8555_defconfig       |   96 +++++--
 arch/powerpc/configs/85xx/tqm8560_defconfig       |   96 +++++--
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  281 ++++++++++++++++------
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  177 +++++++++----
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  175 +++++++++----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  152 +++++++----
 arch/powerpc/configs/adder875_defconfig           |   69 +++--
 arch/powerpc/configs/c2k_defconfig                |  179 ++++++++------
 arch/powerpc/configs/ep8248e_defconfig            |  113 +++++---
 arch/powerpc/configs/ep88xc_defconfig             |   67 +++--
 arch/powerpc/configs/linkstation_defconfig        |  122 +++++++--
 arch/powerpc/configs/mgcoge_defconfig             |  234 ++++++++++++++----
 arch/powerpc/configs/mgsuvd_defconfig             |  107 +++++---
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   78 ++++--
 arch/powerpc/configs/mpc8272_ads_defconfig        |  113 +++++---
 arch/powerpc/configs/mpc83xx_defconfig            |  156 +++++++-----
 arch/powerpc/configs/mpc85xx_defconfig            |  145 +++++++++--
 arch/powerpc/configs/mpc866_ads_defconfig         |   77 ++++--
 arch/powerpc/configs/mpc86xx_defconfig            |  144 +++++++++--
 arch/powerpc/configs/mpc885_ads_defconfig         |   67 +++--
 arch/powerpc/configs/pq2fads_defconfig            |  137 ++++++----
 arch/powerpc/configs/prpmc2800_defconfig          |  126 +++++++--
 arch/powerpc/configs/storcenter_defconfig         |   83 ++++--
 arch/powerpc/include/asm/immap_cpm2.h             |    9
 arch/powerpc/include/asm/immap_qe.h               |    5
 arch/powerpc/kernel/misc_32.S                     |    4
 drivers/watchdog/booke_wdt.c                      |    5
 55 files changed, 4247 insertions(+), 1944 deletions(-)

Kumar Gala (2):
      powerpc/fsl-booke: Fix synchronization bug w/local tlb invalidates
      powerpc: Updated Freescale PPC related defconfigs

Li Yang (1):
      powerpc: Update QE/CPM2 usb_ctlr structures for USB support

Martyn Welch (1):
      powerpc/86xx: Correct SOC bus-frequency in GE Fanuc SBC610 DTS

Matthias Fuchs (1):
      powerpc: Fix Book-E watchdog timer interval setting

The majority of this is defconfig updates, but the other patches are
either compile files (Li Yang) or regressions/bug fixes (Kumar/tlb
invalidate, Martyn, Matthais).  Please pick this up and forward to Linus.

- k
