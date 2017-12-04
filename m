Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrH4R5smGzDwNX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 07:47:19 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id u25so9433636pfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 12:47:19 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style level
Date: Mon,  4 Dec 2017 12:46:33 -0800
Message-Id: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

==Background==
The fsl_ssi driver was designed for PPC originally and then it has
been updated to support different modes for i.MX Series, including
SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
contributors for different use cases in different coding styles.

Additionally, in order to fix/work-around hardware bugs and design
flaws, the driver made a lot of compromise so now its program flow
looks very complicated and it's getting hard to maintain or update.

So I am going to clean up the driver in both coding style level and
program flow level.

==Introduction==
This series of patches is the first set to clean up fsl_ssi driver
in the coding style level. Any patch here is not supposed to change
the program flow.

==Verification==
Theoretically, it only needs code review, build and sanity tests. I
have done build and sanity tests on an i.MX 6 platform by building
using imx_v6_v7_defconfig and testing with I2S slave/master mode.

Nicolin Chen (10):
  ASoC: fsl_ssi: Remove unused struct device
  ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
  ASoC: fsl_ssi: Cache pdev->dev pointer
  ASoC: fsl_ssi: Refine all comments
  ASoC: fsl_ssi: Rename registers and fields macros
  ASoC: fsl_ssi: Refine indentations and wrappings
  ASoC: fsl_ssi: Refine printk outputs
  ASoC: fsl_ssi: Rename cpu_dai parameter to dai
  ASoC: fsl_ssi: Rename scr_val to scr
  ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals

 sound/soc/fsl/fsl_ssi.c     | 1338 +++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  422 ++++++++------
 sound/soc/fsl/fsl_ssi_dbg.c |   59 +-
 3 files changed, 846 insertions(+), 973 deletions(-)

-- 
2.7.4
