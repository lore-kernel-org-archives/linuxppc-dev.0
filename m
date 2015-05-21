Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by lists.ozlabs.org (Postfix) with ESMTP id 8E3E31A0AD5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 22:12:28 +1000 (AEST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 7597036962
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 14:02:18 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>,
 Jiri Kosina <trivial@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ASoC: fsl_esai: Spelling s/specifially/specifically/
Date: Thu, 21 May 2015 14:02:18 +0200
Message-Id: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c7597191e3ffc68..45eee131c47d43cd 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -517,7 +517,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 	u32 bclk, mask, val;
 	int ret;
 
-	/* Override slot_width if being specifially set */
+	/* Override slot_width if being specifically set */
 	if (esai_priv->slot_width)
 		slot_width = esai_priv->slot_width;
 
-- 
1.9.1
