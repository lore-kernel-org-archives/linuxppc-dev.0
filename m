Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWQGv5w9fzDr1h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 05:12:39 +1000 (AEST)
Received: by mail-wm0-f68.google.com with SMTP id d40so15445103wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 12:12:39 -0700 (PDT)
Date: Mon, 14 Aug 2017 21:12:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, brian.austin@cirrus.com,
 Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, bardliao@realtek.com,
 chiou@realtek.com, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
 yang.jie@linux.intel.com, peter.ujfalusi@ti.com,
 jarkko.nikula@bitmer.com, daniel@zonque.org,
 haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 plai@codeaurora.org, bgoswami@codeaurora.org, sbkim73@samsung.com,
 s.nawrocki@samsung.com, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11] ASoC: samsung: make snd_soc_platform_driver const
Message-ID: <20170814191233.oxommdb5r5nf2c2e@kozik-lap>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-9-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1502710730-18912-9-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 14, 2017 at 05:08:47PM +0530, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the function
> devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  sound/soc/samsung/idma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
