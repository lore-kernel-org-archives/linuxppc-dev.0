Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0104.hostedemail.com
 [216.40.44.104])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd67C4HzHzDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:25:59 +1100 (AEDT)
From: Joe Perches <joe@perches.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl_asrc: Fix line continuation format
Date: Thu, 16 Nov 2017 08:25:46 -0800
Message-Id: <370a4a8e3963eb4dc4c4e13defda5170eee72753.1510849466.git.joe@perches.com>
In-Reply-To: <cover.1510849466.git.joe@perches.com>
References: <cover.1510849466.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Line continuations with excess spacing causes unexpected output

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 806d39927318..ed683fe8b94a 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -288,8 +288,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 
 	if ((outrate > 8000 && outrate < 30000) &&
 	    (outrate/inrate > 24 || inrate/outrate > 8)) {
-		pair_err("exceed supported ratio range [1/24, 8] for \
-				inrate/outrate: %d/%d\n", inrate, outrate);
+		pair_err("exceed supported ratio range [1/24, 8] for inrate/outrate: %d/%d\n",
+			 inrate, outrate);
 		return -EINVAL;
 	}
 
-- 
2.15.0
