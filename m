Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxwQS05c1zDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:07:11 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e69so1013314pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 03:07:11 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 fabio.estevam@nxp.com, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-omap@vger.kernel.org
Subject: [PATCH 0/3] ASoC: Handle return value of devm_kasprintf
Date: Wed, 20 Sep 2017 15:36:08 +0530
Message-Id: <1505901971-12004-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

devm_kasprintf() can fail here and we must check its return value.

Arvind Yadav (3):
  [PATCH 1/3] ASoC: davinci-mcasp: Handle return value of devm_kasprintf
  [PATCH 2/3] ASoC: fsl-asoc-card: Handle return value of devm_kasprintf
  [PATCH 3/3] ASoC: omap-hdmi-audio: Handle return value of devm_kasprintf

 sound/soc/davinci/davinci-mcasp.c | 12 ++++++++++++
 sound/soc/fsl/fsl-asoc-card.c     |  2 ++
 sound/soc/omap/omap-hdmi-audio.c  |  3 +++
 3 files changed, 17 insertions(+)

-- 
1.9.1
