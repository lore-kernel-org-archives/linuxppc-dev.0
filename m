Return-Path: <robert.jarzmik@free.fr>
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr
 [80.12.242.125])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcyK310QTzDqm5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 05:33:42 +1000 (AEST)
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 bardliao@realtek.com, chiou@realtek.com, timur@tabi.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 yang.jie@linux.intel.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, krzk@kernel.org, sbkim73@samsung.com,
 s.nawrocki@samsung.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/11] ASoC: pxa: make snd_soc_platform_driver const
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-7-git-send-email-bhumirks@gmail.com>
Date: Wed, 23 Aug 2017 21:33:26 +0200
Message-ID: <87wp5uoz95.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bhumika Goyal <bhumirks@gmail.com> writes:

> Make these const as they are only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/pxa/mmp-pcm.c    | 2 +-
>  sound/soc/pxa/pxa2xx-pcm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For sound/soc/pxa/pxa2xx-pcm.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
