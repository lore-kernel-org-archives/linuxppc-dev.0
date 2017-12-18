Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x229.google.com (mail-pl0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0QZq1C3LzDrqV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 13:53:22 +1100 (AEDT)
Received: by mail-pl0-x229.google.com with SMTP id bd8so3995943plb.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 18:53:22 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
Date: Sun, 17 Dec 2017 18:51:59 -0800
Message-Id: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

==Changelog==
v3->v4
 * Revised PATCH-03 "Refine all comments" by adding Timur's inputs
 * Rebased all other patches
v2->v3
 * Added Tested-by and Reviewed-by from Maciej
 * Revised PATCH-03 "Refine all comments" by adding Maciej's advice
 * Revised PATCH-05 "Refine indentations and wrappings"
 * Rebased all other patches
v1->v2
 * Dropped one patch to remove "struct device"
 * Revised PATCH-03 "Refine all comments"
 * Revised PATCH-05 "Refine indentations and wrappings"
 * Rebased all other patches
 * Added PATCH-10 "Rename i2smode to i2s_net"
 * Added PATCH-11 "Define ternary macros to simplify code"

 # Detialed changes are described in each updated patch.

Nicolin Chen (11):
  ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
  ASoC: fsl_ssi: Cache pdev->dev pointer
  ASoC: fsl_ssi: Refine all comments
  ASoC: fsl_ssi: Rename registers and fields macros
  ASoC: fsl_ssi: Refine indentations and wrappings
  ASoC: fsl_ssi: Refine printk outputs
  ASoC: fsl_ssi: Rename cpu_dai parameter to dai
  ASoC: fsl_ssi: Rename scr_val to scr
  ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals
  ASoC: fsl_ssi: Rename i2smode to i2s_net
  ASoC: fsl_ssi: Define ternary macros to simplify code

 sound/soc/fsl/fsl_ssi.c     | 1380 +++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  427 +++++++------
 sound/soc/fsl/fsl_ssi_dbg.c |   59 +-
 3 files changed, 896 insertions(+), 970 deletions(-)

-- 
2.7.4
