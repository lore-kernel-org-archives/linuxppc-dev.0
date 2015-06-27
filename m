Return-Path: <festevam@gmail.com>
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com
 [IPv6:2a00:1450:4010:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95A301A0359
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 09:09:34 +1000 (AEST)
Received: by lacny3 with SMTP id ny3so89929816lac.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2015 16:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <558F28E1.7040204@maciej.szmigiero.name>
References: <558F28E1.7040204@maciej.szmigiero.name>
Date: Sat, 27 Jun 2015 20:09:30 -0300
Message-ID: <CAOMZO5AkwGkj-Qmv6k+A7aV=SeuoPD1Mcc-hBFtuLSs2iaBSJA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 27, 2015 at 7:51 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> +
> +       ret = clk_prepare_enable(fsl_ac97_data->clk);
> +       if (ret) {
> +               pr_err("ac97 read clk_prepare_enable failed: %d\n",
> +                       ret);
> +               return -1;

'return ret' would be better here.

Thanks
