Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87D46DDFB9
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 01:22:26 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m39FMInj009887
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 10:22:20 -0500
Date: Wed, 9 Apr 2008 10:18:06 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Message-ID: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Board specific defconfigs are useful, however with the ability to do
multi-board defconfigs they aren't needed in the top level configs directory

Move the 83xx/85xx board specific defconfigs to individual directories under
arch/powerpc/configs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 .../configs/{ => 83xx}/mpc8313_rdb_defconfig       |    0
 .../configs/{ => 83xx}/mpc8315_rdb_defconfig       |    0
 .../configs/{ => 83xx}/mpc832x_mds_defconfig       |    0
 .../configs/{ => 83xx}/mpc832x_rdb_defconfig       |    0
 .../configs/{ => 83xx}/mpc834x_itx_defconfig       |    0
 .../configs/{ => 83xx}/mpc834x_itxgp_defconfig     |    0
 .../configs/{ => 83xx}/mpc834x_mds_defconfig       |    0
 .../configs/{ => 83xx}/mpc836x_mds_defconfig       |    0
 .../configs/{ => 83xx}/mpc837x_mds_defconfig       |    0
 .../configs/{ => 83xx}/mpc837x_rdb_defconfig       |    0
 arch/powerpc/configs/{ => 83xx}/sbc834x_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/ksi8560_defconfig  |    0
 .../configs/{ => 85xx}/mpc8540_ads_defconfig       |    0
 .../configs/{ => 85xx}/mpc8544_ds_defconfig        |    0
 .../configs/{ => 85xx}/mpc8560_ads_defconfig       |    0
 .../configs/{ => 85xx}/mpc8568mds_defconfig        |    0
 .../configs/{ => 85xx}/mpc8572_ds_defconfig        |    0
 .../configs/{ => 85xx}/mpc85xx_cds_defconfig       |    0
 arch/powerpc/configs/{ => 85xx}/sbc8548_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/sbc8560_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/stx_gp3_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/tqm8540_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/tqm8541_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/tqm8555_defconfig  |    0
 arch/powerpc/configs/{ => 85xx}/tqm8560_defconfig  |    0
 25 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/powerpc/configs/{ => 83xx}/mpc8313_rdb_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc8315_rdb_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc832x_mds_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc832x_rdb_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc834x_itx_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc834x_itxgp_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc834x_mds_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc836x_mds_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc837x_mds_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/mpc837x_rdb_defconfig (100%)
 rename arch/powerpc/configs/{ => 83xx}/sbc834x_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/ksi8560_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc8540_ads_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc8544_ds_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc8560_ads_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc8568mds_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc8572_ds_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/mpc85xx_cds_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/sbc8548_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/sbc8560_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/stx_gp3_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/tqm8540_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/tqm8541_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/tqm8555_defconfig (100%)
 rename arch/powerpc/configs/{ => 85xx}/tqm8560_defconfig (100%)

diff --git a/arch/powerpc/configs/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8313_rdb_defconfig
rename to arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
diff --git a/arch/powerpc/configs/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8315_rdb_defconfig
rename to arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
diff --git a/arch/powerpc/configs/mpc832x_mds_defconfig b/arch/powerpc/configs/83xx/mpc832x_mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc832x_mds_defconfig
rename to arch/powerpc/configs/83xx/mpc832x_mds_defconfig
diff --git a/arch/powerpc/configs/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc832x_rdb_defconfig
rename to arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc834x_itx_defconfig
rename to arch/powerpc/configs/83xx/mpc834x_itx_defconfig
diff --git a/arch/powerpc/configs/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc834x_itxgp_defconfig
rename to arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/83xx/mpc834x_mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc834x_mds_defconfig
rename to arch/powerpc/configs/83xx/mpc834x_mds_defconfig
diff --git a/arch/powerpc/configs/mpc836x_mds_defconfig b/arch/powerpc/configs/83xx/mpc836x_mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc836x_mds_defconfig
rename to arch/powerpc/configs/83xx/mpc836x_mds_defconfig
diff --git a/arch/powerpc/configs/mpc837x_mds_defconfig b/arch/powerpc/configs/83xx/mpc837x_mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc837x_mds_defconfig
rename to arch/powerpc/configs/83xx/mpc837x_mds_defconfig
diff --git a/arch/powerpc/configs/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc837x_rdb_defconfig
rename to arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
diff --git a/arch/powerpc/configs/sbc834x_defconfig b/arch/powerpc/configs/83xx/sbc834x_defconfig
similarity index 100%
rename from arch/powerpc/configs/sbc834x_defconfig
rename to arch/powerpc/configs/83xx/sbc834x_defconfig
diff --git a/arch/powerpc/configs/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
similarity index 100%
rename from arch/powerpc/configs/ksi8560_defconfig
rename to arch/powerpc/configs/85xx/ksi8560_defconfig
diff --git a/arch/powerpc/configs/mpc8540_ads_defconfig b/arch/powerpc/configs/85xx/mpc8540_ads_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8540_ads_defconfig
rename to arch/powerpc/configs/85xx/mpc8540_ads_defconfig
diff --git a/arch/powerpc/configs/mpc8544_ds_defconfig b/arch/powerpc/configs/85xx/mpc8544_ds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8544_ds_defconfig
rename to arch/powerpc/configs/85xx/mpc8544_ds_defconfig
diff --git a/arch/powerpc/configs/mpc8560_ads_defconfig b/arch/powerpc/configs/85xx/mpc8560_ads_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8560_ads_defconfig
rename to arch/powerpc/configs/85xx/mpc8560_ads_defconfig
diff --git a/arch/powerpc/configs/mpc8568mds_defconfig b/arch/powerpc/configs/85xx/mpc8568mds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8568mds_defconfig
rename to arch/powerpc/configs/85xx/mpc8568mds_defconfig
diff --git a/arch/powerpc/configs/mpc8572_ds_defconfig b/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc8572_ds_defconfig
rename to arch/powerpc/configs/85xx/mpc8572_ds_defconfig
diff --git a/arch/powerpc/configs/mpc85xx_cds_defconfig b/arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
similarity index 100%
rename from arch/powerpc/configs/mpc85xx_cds_defconfig
rename to arch/powerpc/configs/85xx/mpc85xx_cds_defconfig
diff --git a/arch/powerpc/configs/sbc8548_defconfig b/arch/powerpc/configs/85xx/sbc8548_defconfig
similarity index 100%
rename from arch/powerpc/configs/sbc8548_defconfig
rename to arch/powerpc/configs/85xx/sbc8548_defconfig
diff --git a/arch/powerpc/configs/sbc8560_defconfig b/arch/powerpc/configs/85xx/sbc8560_defconfig
similarity index 100%
rename from arch/powerpc/configs/sbc8560_defconfig
rename to arch/powerpc/configs/85xx/sbc8560_defconfig
diff --git a/arch/powerpc/configs/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
similarity index 100%
rename from arch/powerpc/configs/stx_gp3_defconfig
rename to arch/powerpc/configs/85xx/stx_gp3_defconfig
diff --git a/arch/powerpc/configs/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
similarity index 100%
rename from arch/powerpc/configs/tqm8540_defconfig
rename to arch/powerpc/configs/85xx/tqm8540_defconfig
diff --git a/arch/powerpc/configs/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
similarity index 100%
rename from arch/powerpc/configs/tqm8541_defconfig
rename to arch/powerpc/configs/85xx/tqm8541_defconfig
diff --git a/arch/powerpc/configs/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
similarity index 100%
rename from arch/powerpc/configs/tqm8555_defconfig
rename to arch/powerpc/configs/85xx/tqm8555_defconfig
diff --git a/arch/powerpc/configs/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
similarity index 100%
rename from arch/powerpc/configs/tqm8560_defconfig
rename to arch/powerpc/configs/85xx/tqm8560_defconfig
-- 
1.5.4.1
