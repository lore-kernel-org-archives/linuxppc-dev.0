Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY0xd4RbKzDrKt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 19:18:13 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y129so8931196pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 02:18:13 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, linux@armlinux.org.uk, perex@perex.cz,
 tiwai@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 12/12] ALSA: parisc: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 14:46:00 +0530
Message-Id: <1502961360-22063-13-git-send-email-bhumirks@gmail.com>
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

Make these const as they are only used in a copy operation.
Done using Coccinelle

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/parisc/harmony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index 5911eb3..cb2bc54 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -260,7 +260,7 @@
 	return HARMONY_SR_44KHZ;
 }
 
-static struct snd_pcm_hardware snd_harmony_playback =
+static const struct snd_pcm_hardware snd_harmony_playback =
 {
 	.info =	(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED | 
 		 SNDRV_PCM_INFO_JOINT_DUPLEX | SNDRV_PCM_INFO_MMAP_VALID |
@@ -281,7 +281,7 @@
 	.fifo_size = 0,
 };
 
-static struct snd_pcm_hardware snd_harmony_capture =
+static const struct snd_pcm_hardware snd_harmony_capture =
 {
         .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                  SNDRV_PCM_INFO_JOINT_DUPLEX | SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
