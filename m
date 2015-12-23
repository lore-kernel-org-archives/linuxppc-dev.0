Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x234.google.com (mail-ig0-x234.google.com
 [IPv6:2607:f8b0:4001:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4A111A0E58
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 00:13:17 +1100 (AEDT)
Received: by mail-ig0-x234.google.com with SMTP id ph11so80537637igc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 05:13:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5677107C.60904@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>
Date: Wed, 23 Dec 2015 11:13:15 -0200
Message-ID: <CAOMZO5CXGD60N0OdsH+F18yX6tq10CCPm4fuUhkLNaxzvbpB7Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
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

On Sun, Dec 20, 2015 at 6:33 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> There is no guarantee that on fsl_ssi module load
> SSI registers will have their power-on-reset values.
>
> In fact, if the driver is reloaded the values in
> registers will be whatever they were set to previously.
>
> This fixes hard lockup on fsl_ssi module reload,
> at least in AC'97 mode.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
