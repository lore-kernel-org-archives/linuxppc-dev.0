Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0143.outbound.protection.outlook.com [157.56.111.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E03F91A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 20:56:14 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <nicoleotsuka@gmail.com>
Subject: [PATCH 0/3] Add sai master mode,
 tdm slot operation and add some sample rate support
Date: Mon, 11 May 2015 18:24:40 +0800
Message-ID: <cover.1431337606.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add SAI master mode support.
Add tdm slots operation for SAI master mode.
Add 12kHz, 24kHz, 176.4kHz and 192kHz sample rate support.

Zidan Wang (3):
  SoC: fsl_sai: add sai master mode support
  ASoC: fsl_sai: Add tdm slots operation for SAI master mode
  ASoC: fsl_sai: add 12kHz, 24kHz, 176.4kHz and 192kHz sample rate
    support

 sound/soc/fsl/fsl_sai.c | 165 +++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h |  12 +++-
 2 files changed, 165 insertions(+), 12 deletions(-)

-- 
1.9.1
