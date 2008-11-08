Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57E11DDDDB
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 05:42:32 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mA8IgR4e016557
	for <linuxppc-dev@ozlabs.org>; Sat, 8 Nov 2008 12:42:28 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Updated Freescale PPC related defconfigs
Date: Sat,  8 Nov 2008 12:42:27 -0600
Message-Id: <1226169747-3414-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

unset CONFIG_PCI_LEGACY in the defconfigs as none of them enable
ISDN drivers which seem to be the only place we are using pci_find_device

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/83xx/asp8347_defconfig       |  121 ++++++----
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |  158 ++++++++-----
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |  158 ++++++++-----
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |  125 ++++++----
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |  136 ++++++----
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |  171 +++++++++----
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |  121 ++++++----
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |  123 ++++++----
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |  126 ++++++----
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |  119 +++++----
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  123 ++++++----
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  155 ++++++++----
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  119 +++++----
 arch/powerpc/configs/85xx/ksi8560_defconfig       |   87 +++++--
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |   74 ++++--
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |   90 +++++--
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |   93 ++++++--
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |  143 +++++++++--
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |   91 +++++--
 arch/powerpc/configs/85xx/sbc8548_defconfig       |   75 ++++--
 arch/powerpc/configs/85xx/sbc8560_defconfig       |   78 +++++--
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |  115 ++++++---
 arch/powerpc/configs/85xx/tqm8540_defconfig       |   91 +++++--
 arch/powerpc/configs/85xx/tqm8541_defconfig       |   96 +++++---
 arch/powerpc/configs/85xx/tqm8548_defconfig       |   98 ++++++--
 arch/powerpc/configs/85xx/tqm8555_defconfig       |   96 +++++---
 arch/powerpc/configs/85xx/tqm8560_defconfig       |   96 +++++---
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |  281 ++++++++++++++++-----
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |  177 +++++++++----
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |  175 +++++++++----
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |  152 +++++++-----
 arch/powerpc/configs/adder875_defconfig           |   69 ++++--
 arch/powerpc/configs/c2k_defconfig                |  179 ++++++++-----
 arch/powerpc/configs/ep8248e_defconfig            |  113 +++++----
 arch/powerpc/configs/ep88xc_defconfig             |   67 ++++--
 arch/powerpc/configs/linkstation_defconfig        |  122 +++++++---
 arch/powerpc/configs/mgcoge_defconfig             |  234 ++++++++++++++----
 arch/powerpc/configs/mgsuvd_defconfig             |  107 ++++++---
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |   78 +++++--
 arch/powerpc/configs/mpc8272_ads_defconfig        |  113 +++++----
 arch/powerpc/configs/mpc83xx_defconfig            |  156 ++++++++----
 arch/powerpc/configs/mpc85xx_defconfig            |  145 +++++++++--
 arch/powerpc/configs/mpc866_ads_defconfig         |   77 ++++--
 arch/powerpc/configs/mpc86xx_defconfig            |  144 +++++++++--
 arch/powerpc/configs/mpc885_ads_defconfig         |   67 ++++--
 arch/powerpc/configs/pq2fads_defconfig            |  137 ++++++-----
 arch/powerpc/configs/prpmc2800_defconfig          |  126 +++++++---
 arch/powerpc/configs/storcenter_defconfig         |   83 ++++--
 50 files changed, 4234 insertions(+), 1932 deletions(-)

(patch is in my merge tree if you want to really see it)

- k
