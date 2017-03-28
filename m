Return-Path: <daniel.baluta@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30089.outbound.protection.outlook.com [40.107.3.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vslF71xWgzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 19:59:06 +1100 (AEDT)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: <nicoleotsuka@gmail.com>, <broonie@kernel.org>,
 <alsa-devel@alsa-project.org>
CC: <timur@tabi.org>, <Xiubo.Lee@gmail.com>, <fabio.estevam@nxp.com>,
 <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] imx-wm8962: Let codec driver enable/disable its MCLK
Date: Tue, 28 Mar 2017 11:58:50 +0300
Message-ID: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a small cleanup patch series which removes MLCK enable/disable
from imx-wm8962 machine driver and lets the codec handle that.

While reviewing this, Nicolin noticed that codec_clk cleanup is not correct
so the second patch fixes this.

Changes since v2:
	* added 2/2 patch to fix codec_clk cleanup
	* fixed prefix subject

Daniel Baluta (2):
  ASoC: imx-wm8962: Let codec driver enable/disable its MCLK
  ASoC: imx-wm8962: Fix codec_clk cleanup

 sound/soc/fsl/imx-wm8962.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

-- 
2.7.4
