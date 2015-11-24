Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 526F21A004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 20:19:33 +1100 (AEDT)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>, <timur@tabi.org>,
 <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
 <shawnguo@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 0/3] add spba clock for fsl audio IP
Date: Tue, 24 Nov 2015 17:19:31 +0800
Message-ID: <cover.1448356624.git.shengjiu.wang@freescale.com>
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

add spba clock for fsl audio IP

Changes in V3
- add error check for spba clock

Shengjiu Wang (3):
  ASoC: fsl_esai: spba clock is needed by esai device
  ASoC: fsl_spdif: spba clk is needed by spdif device
  ASoC: fsl_asrc: spba clock is needed by asrc device

 Documentation/devicetree/bindings/sound/fsl,asrc.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  5 +++++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++
 sound/soc/fsl/fsl_asrc.c                              | 14 ++++++++++++++
 sound/soc/fsl/fsl_asrc.h                              |  2 ++
 sound/soc/fsl/fsl_esai.c                              | 17 +++++++++++++++++
 sound/soc/fsl/fsl_spdif.c                             | 19 +++++++++++++++++++
 7 files changed, 67 insertions(+)

-- 
1.9.1
