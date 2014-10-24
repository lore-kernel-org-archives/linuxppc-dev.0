Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4CC11A0053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Oct 2014 10:48:25 +1100 (AEDT)
Received: by mail-pd0-f175.google.com with SMTP id y13so2285308pdi.20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 16:48:23 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	b02247@freescale.com
Subject: [PATCH 0/2] ASoC: fsl: Use dynamic slot width for ESAI.
Date: Fri, 24 Oct 2014 16:48:10 -0700
Message-Id: <cover.1414193668.git.nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches add the support of dynamic slot width for
ESAI driver. To do this, the PATCH-1 removes the fixed width. In
order not to break those platforms that use fixed width, there
comes the PATCH-2 to apply an override of slot_width.

@Shengjiu,
Will you be available to test this series on Sabre Auto for both
Master and Slave cases? I'd like to wait for your Test-by. Thanks.

Nicolin Chen (2):
  ASoC: fsl_esai: Use dynamic slot width as default
  ASoC: fsl-asoc-card: Add slot_width setting for cpu-dai

 sound/soc/fsl/fsl-asoc-card.c | 12 ++++++++++++
 sound/soc/fsl/fsl_esai.c      | 12 +++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
1.9.1
