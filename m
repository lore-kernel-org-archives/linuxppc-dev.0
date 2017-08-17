Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0vq6QwTzDrL6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:16:39 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 83so8927367pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:16:39 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 01/12] ALSA: arm: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:45:49 +0530
Message-Id: <1502961360-22063-2-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
References: <1502961360-22063-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make this const as it is only used in a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/arm/aaci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..74cf452 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -348,7 +348,7 @@ static irqreturn_t aaci_irq(int irq, void *devid)
 /*
  * ALSA support.
  */
-static struct snd_pcm_hardware aaci_hw_info = {
+static const struct snd_pcm_hardware aaci_hw_info = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_INTERLEAVED |
-- 
1.9.1
