Return-Path: <festevam@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com
 [IPv6:2607:f8b0:4001:c06::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9824C1A011E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 23:51:54 +1100 (AEDT)
Received: by mail-io0-x230.google.com with SMTP id 77so516805353ioc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 04:51:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <569C0F86.2020509@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <5693B4C1.4060400@maciej.szmigiero.name>
 <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
 <569AD8A7.7080803@maciej.szmigiero.name>
 <569ADC0D.2000807@tabi.org>
 <569AE7D1.6050607@maciej.szmigiero.name>
 <569B23A8.3010006@tabi.org>
 <569BA225.8070509@maciej.szmigiero.name>
 <569BA786.4020305@maciej.szmigiero.name>
 <569BDFB3.1080401@tabi.org>
 <569C0F86.2020509@maciej.szmigiero.name>
Date: Mon, 18 Jan 2016 10:51:51 -0200
Message-ID: <CAOMZO5BpwoJAPxtHRu6wH+SS=yqszgqt42u+V2N7K3r_Neh_Ww@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Timur Tabi <timur@tabi.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
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

Hi Maciej,

On Sun, Jan 17, 2016 at 8:02 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> Patch updated according to Timur's suggestions (needs regmap fix):
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c

Tested your patch against linux-next and it did not give me any warnings:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
