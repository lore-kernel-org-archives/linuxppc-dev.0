Return-Path: <festevam@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 538EE1A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 01:05:29 +1100 (AEDT)
Received: by mail-io0-x244.google.com with SMTP id 77so11044040ioc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 06:05:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5693B4C1.4060400@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <5693B4C1.4060400@maciej.szmigiero.name>
Date: Mon, 11 Jan 2016 12:05:26 -0200
Message-ID: <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
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

Hi Maciej,

On Mon, Jan 11, 2016 at 11:57 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Hi Fabio,

> This will disable register cache so it isn't right.
> Could you try REGCACHE_FLAT instead, please?

Yes, with REGCACHE_FLAT I don't get the warning.

Regards,

Fabio Estevam
