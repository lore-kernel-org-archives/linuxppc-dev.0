Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf5Fm2435zDqpG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 22:48:27 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_spdif: fix spelling mistake: "receivce" -> "receive"
Date: Tue, 28 Jun 2016 13:47:59 +0100
Message-Id: <1467118079-8652-1-git-send-email-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/fsl/fsl_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 151849f..beec793 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -172,7 +172,7 @@ static void spdif_irq_uqrx_full(struct fsl_spdif_priv *spdif_priv, char name)
 	if (*pos >= size * 2) {
 		*pos = 0;
 	} else if (unlikely((*pos % size) + 3 > size)) {
-		dev_err(&pdev->dev, "User bit receivce buffer overflow\n");
+		dev_err(&pdev->dev, "User bit receive buffer overflow\n");
 		return;
 	}
 
-- 
2.8.1
