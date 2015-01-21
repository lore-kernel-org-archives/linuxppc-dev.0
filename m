Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22c.google.com (mail-la0-x22c.google.com
 [IPv6:2a00:1450:4010:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3781E1A0D0E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 12:16:00 +1100 (AEDT)
Received: by mail-la0-f44.google.com with SMTP id s18so4334888lam.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 17:15:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
Date: Tue, 20 Jan 2015 23:15:54 -0200
Message-ID: <CAOMZO5DcpSsRi4UE8gCjT+w=OueB1pWtQPYphgeEsMNZ_EvK5w@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 0/3] Add master mode,
 tmd and right-j mode support
From: Fabio Estevam <festevam@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com, Takashi Iwai <tiwai@suse.de>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zidan,

On Tue, Jan 20, 2015 at 10:21 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> Add sai master mode support.
> Add tdm slots support.
> Add Right-J mode support.
>
> Zidan Wang (3):
>   SoC: fsl_sai: add sai master mode support
>   ASoC: fsl_sai: Add support for tdm slots operation
>   ASoC: fsl_sai: Add support for Right-J mode
>
>  sound/soc/fsl/fsl_sai.c | 164 ++++++++++++++++++++++++++++++++++++++++++++----
>  sound/soc/fsl/fsl_sai.h |  13 +++-
>  2 files changed, 164 insertions(+), 13 deletions(-)

Not related to your series, but do you have a patch for imx6sx-sdb.dts
that adds sai support?

In the FSL version they use 'fsl,sdma-event-remap' property to specify
the SAI sdma channels, but this is not present in mainline? How are
you dealing with it?
