Return-Path: <fabf@skynet.be>
Received: from mailrelay106.isp.belgacom.be (mailrelay106.isp.belgacom.be
 [195.238.20.133])
 by lists.ozlabs.org (Postfix) with ESMTP id 025191A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 03:49:22 +1100 (AEDT)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/7 linux-next] sound: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:55 +0100
Message-Id: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Fabian Frederick <fabf@skynet.be>,
 Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>,
 Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This small patchset adds const to of_device_id arrays in
sound branch.

Fabian Frederick (7):
  ALSA: aoa: constify of_device_id array
  ASoC: fsl: constify of_device_id array
  ASoC: kirkwood: constify of_device_id array
  ASoC: rt5631: constify of_device_id array
  ASoC: ak4554: constify of_device_id array
  ASoC: fsi: constify of_device_id array
  ASoC: rsnd: constify of_device_id array

 sound/aoa/soundbus/i2sbus/core.c    | 2 +-
 sound/soc/codecs/ak4554.c           | 2 +-
 sound/soc/codecs/rt5631.c           | 2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c    | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c     | 2 +-
 sound/soc/fsl/pcm030-audio-fabric.c | 2 +-
 sound/soc/kirkwood/kirkwood-i2s.c   | 2 +-
 sound/soc/sh/fsi.c                  | 4 ++--
 sound/soc/sh/rcar/core.c            | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1
