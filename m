Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5716DDDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 01:01:47 +1100 (EST)
Date: Mon, 24 Mar 2008 08:58:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branch
Message-ID: <Pine.LNX.4.64.0803240857420.13752@blarg.am.freescale.net>
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

 arch/powerpc/configs/ep8248e_defconfig       |   74 +++++++---
 arch/powerpc/configs/ep88xc_defconfig        |   56 +++++--
 arch/powerpc/configs/linkstation_defconfig   |  131 +++++++++++------
 arch/powerpc/configs/mpc7448_hpc2_defconfig  |  119 ++++++++++++----
 arch/powerpc/configs/mpc8272_ads_defconfig   |   75 ++++++++--
 arch/powerpc/configs/mpc8313_rdb_defconfig   |  114 ++++++++++-----
 arch/powerpc/configs/mpc8315_rdb_defconfig   |  110 +++++++++------
 arch/powerpc/configs/mpc832x_mds_defconfig   |  101 +++++++++----
 arch/powerpc/configs/mpc832x_rdb_defconfig   |  106 +++++++++-----
 arch/powerpc/configs/mpc834x_itx_defconfig   |  111 +++++++++------
 arch/powerpc/configs/mpc834x_itxgp_defconfig |  109 +++++++++-----
 arch/powerpc/configs/mpc834x_mds_defconfig   |  104 +++++++++-----
 arch/powerpc/configs/mpc836x_mds_defconfig   |  102 +++++++++----
 arch/powerpc/configs/mpc837x_mds_defconfig   |  197 ++++++++++++++-------------
 arch/powerpc/configs/mpc837x_rdb_defconfig   |   83 +++++++----
 arch/powerpc/configs/mpc83xx_defconfig       |   88 +++++++-----
 arch/powerpc/configs/mpc8540_ads_defconfig   |  121 ++++++++++++----
 arch/powerpc/configs/mpc8544_ds_defconfig    |  127 ++++++++++++-----
 arch/powerpc/configs/mpc8560_ads_defconfig   |  126 +++++++++++++----
 arch/powerpc/configs/mpc8568mds_defconfig    |  106 ++++++++++----
 arch/powerpc/configs/mpc8572_ds_defconfig    |  127 ++++++++++++-----
 arch/powerpc/configs/mpc85xx_cds_defconfig   |  131 +++++++++++++----
 arch/powerpc/configs/mpc85xx_defconfig       |  111 ++++++++++-----
 arch/powerpc/configs/mpc8610_hpcd_defconfig  |  131 ++++++++++++++---
 arch/powerpc/configs/mpc8641_hpcn_defconfig  |  115 ++++++++++-----
 arch/powerpc/configs/mpc866_ads_defconfig    |  112 +++++++++++----
 arch/powerpc/configs/mpc885_ads_defconfig    |   56 +++++--
 arch/powerpc/configs/pq2fads_defconfig       |   89 ++++++++----
 arch/powerpc/configs/prpmc2800_defconfig     |  160 ++++++++++++++++-----
 arch/powerpc/configs/sbc834x_defconfig       |   78 +++++++---
 arch/powerpc/configs/sbc8548_defconfig       |  115 ++++++++++++---
 arch/powerpc/configs/sbc8560_defconfig       |  124 +++++++++++++---
 arch/powerpc/configs/storcenter_defconfig    |  102 +++++++------
 arch/powerpc/configs/stx_gp3_defconfig       |  154 +++++++++++++++------
 arch/powerpc/configs/tqm8540_defconfig       |  133 +++++++++++++-----
 arch/powerpc/configs/tqm8541_defconfig       |  133 +++++++++++++-----
 arch/powerpc/configs/tqm8555_defconfig       |  133 +++++++++++++-----
 arch/powerpc/configs/tqm8560_defconfig       |  133 +++++++++++++-----
 38 files changed, 3031 insertions(+), 1266 deletions(-)

Kumar Gala (1):
      [POWERPC] Update some defconfigs
