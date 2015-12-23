Return-Path: <festevam@gmail.com>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com
 [IPv6:2607:f8b0:4001:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83C5D1A0E60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 00:12:49 +1100 (AEDT)
Received: by mail-io0-x231.google.com with SMTP id e126so215443624ioa.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 05:12:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56771034.5080702@maciej.szmigiero.name>
References: <56771034.5080702@maciej.szmigiero.name>
Date: Wed, 23 Dec 2015 11:12:47 -0200
Message-ID: <CAOMZO5BmhYX1k5NTLtQR0d-QMO_CWoBYpvsbHLsGPne=Zv1FfA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: mark some registers precious
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

On Sun, Dec 20, 2015 at 6:31 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Mark some registers precious since their
> reads have side effects (like clearing flags).
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
