Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x235.google.com (mail-ig0-x235.google.com
 [IPv6:2607:f8b0:4001:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 556C41A0BDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 00:12:16 +1100 (AEDT)
Received: by mail-ig0-x235.google.com with SMTP id to18so77200873igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 05:12:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
References: <56770FE1.4060202@maciej.szmigiero.name>
Date: Wed, 23 Dec 2015 11:12:12 -0200
Message-ID: <CAOMZO5ASGih_=QZeOZYizxTrjRUehsXdJJNojC+MTULkXD8H0A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
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

On Sun, Dec 20, 2015 at 6:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> SACNT register should be marked volatile since
> its WR and RD bits are cleared by SSI after
> completing the relevant operation.
> This unbreaks AC'97 register access.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
