Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0217.hostedemail.com
 [216.40.44.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd67B4cMyzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:25:57 +1100 (AEDT)
From: Joe Perches <joe@perches.com>
To: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: fsl_asrc: neatening
Date: Thu, 16 Nov 2017 08:25:45 -0800
Message-Id: <cover.1510849466.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches (2):
  ASoC: fsl_asrc: Fix line continuation format
  ASoC: fsl_asrc: constify some arrays

 sound/soc/fsl/fsl_asrc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.15.0
