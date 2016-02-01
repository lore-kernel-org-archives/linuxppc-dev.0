Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 219221A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 23:13:39 +1100 (AEDT)
Received: by mail-ig0-x231.google.com with SMTP id 5so9902649igt.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2016 04:13:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56AF4A9F.4060401@maciej.szmigiero.name>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
 <56AF4A9F.4060401@maciej.szmigiero.name>
Date: Mon, 1 Feb 2016 10:13:37 -0200
Message-ID: <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
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

Hi Maciej,

On Mon, Feb 1, 2016 at 10:07 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Is regmap patch from
> http://www.spinics.net/lists/kernel/msg2161934.html
> applied to the tested tree?

Yes, linux-next 20160201 contains this patch.
