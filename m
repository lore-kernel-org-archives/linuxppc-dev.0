Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF64B1A0881
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 19:33:33 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <timur@tabi.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <nicoleotsuka@gmail.com>,
 <Li.Xiubo@freescale.com>, <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <arnd@arndb.de>
Subject: [PATCH V2 0/2] refine esai for tdm support
Date: Thu, 7 Aug 2014 17:33:23 +0800
Message-ID: <cover.1407403727.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patchs is to refine esai for tdm support.

Changes for V2
- update the comments according the reviewer's suggestion
- add init value for slots and change pin to pins.

Shengjiu Wang (2):
  ASoC: fsl_esai: refine esai for TDM support
  Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."

 sound/soc/fsl/Kconfig    |    1 -
 sound/soc/fsl/fsl_esai.c |   16 +++++++++++-----
 sound/soc/fsl/fsl_esai.h |    8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
1.7.9.5
