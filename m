Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tpgLs523tzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Dec 2016 04:53:09 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id u15so52021348oie.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2016 09:53:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161228110636.GA14768@ubuntu>
References: <20161228110636.GA14768@ubuntu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Dec 2016 15:53:07 -0200
Message-ID: <CAOMZO5DgtyJrFwa0-VZmXZYQVbMxtsHRuoRbAHw5CX2K7aVMkQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC : fsl_ssi : Correct the condition to
 check AC97 mode
To: "Harisangam, Sharvari (S.)" <sharvari.harisangam@visteon.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 28, 2016 at 9:06 AM, Harisangam, Sharvari (S.)
<sharvari.harisangam@visteon.com> wrote:
>  Corrected the condition to check if ssi is configured for AC97
>  mode. Other modes like dsp_a also satisfy the ANDing condition.
>
> Signed-off-by: Sharvari Harisangam <sharvari.harisangam@visteon.com>

This has been fixed in 4.3 kernel by commit:

5b64c173cdea211 ("ASoC: fsl_ssi: Fix checking of dai format for AC97 mode")
