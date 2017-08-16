Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXNF51BXyzDrBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 18:44:25 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u185so4772821pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 01:44:25 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz,
 tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/3] ALSA: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:08 +0530
Message-Id: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make these structures const. Done using Coccinelle.

Bhumika Goyal (3):
  ALSA: aoa: make snd_kcontrol_new const
  ALSA: pcxhr: make snd_kcontrol_new const
  ALSA: hda: make snd_kcontrol_new const

 sound/aoa/codecs/onyx.c        | 12 ++++++------
 sound/pci/hda/patch_analog.c   |  4 ++--
 sound/pci/hda/patch_sigmatel.c |  2 +-
 sound/pci/pcxhr/pcxhr_mixer.c  |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.1
