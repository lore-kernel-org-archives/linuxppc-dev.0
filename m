Return-Path: <zidan.wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A7A31A0CE5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 23:35:32 +1100 (AEDT)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
Subject: [alsa-devel][PATCH 0/3] Add master mode, tmd and right-j mode support
Date: Tue, 20 Jan 2015 20:21:17 +0800
Message-ID: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>,
 Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add sai master mode support.
Add tdm slots support.
Add Right-J mode support.

Zidan Wang (3):
  SoC: fsl_sai: add sai master mode support
  ASoC: fsl_sai: Add support for tdm slots operation
  ASoC: fsl_sai: Add support for Right-J mode

 sound/soc/fsl/fsl_sai.c | 164 ++++++++++++++++++++++++++++++++++++++++++++----
 sound/soc/fsl/fsl_sai.h |  13 +++-
 2 files changed, 164 insertions(+), 13 deletions(-)

-- 
1.9.1
