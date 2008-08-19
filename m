Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 6802BDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 07:39:41 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so272710uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 14:39:39 -0700 (PDT)
Message-ID: <48AA407C.8090409@gmail.com>
Date: Mon, 18 Aug 2008 23:39:40 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: johannes@sipsolutions.net, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

untested, is it correct?
---
duplicate SNDRV_PCM_FMTBIT_S{16,24}_BE

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 7a16a33..c922505 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -654,15 +654,15 @@ static struct snd_kcontrol_new bass_control = {
 static struct transfer_info tas_transfers[] = {
 	{
 		/* input */
-		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
-			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
 		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 		.transfer_in = 1,
 	},
 	{
 		/* output */
-		.formats = SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
-			   SNDRV_PCM_FMTBIT_S24_BE | SNDRV_PCM_FMTBIT_S24_BE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
+			   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE,
 		.rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000,
 		.transfer_in = 0,
 	},
