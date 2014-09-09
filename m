Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E44711A003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 20:11:44 +1000 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>,
 "tiwai@suse.de" <tiwai@suse.de>
Subject: RE: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
Date: Tue, 9 Sep 2014 09:55:41 +0000
Message-ID: <a2df014417624f0790c01b0ccd21853f@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
In-Reply-To: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> Subject: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in this module
>=20
> Move the ipg clock enable and disable operation to startup and shutdown,
> that is only enable ipg clock when ssi is working. we don't need to enabl=
e
> ipg clock in probe.
> Another register accessing need the ipg clock, so use
> devm_regmap_init_mmio_clk
> instead of devm_regmap_init_mmio.
>

You should split this into two separate patches, which will be more
Easy to be reviewed.
=20
Thanks,

BRs
Xiubo
