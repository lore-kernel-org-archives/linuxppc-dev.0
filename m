Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAFE41A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 13:11:25 +1000 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>
Subject: RE: [PATCH 0/2] ASoC: fsl_sai: Two bug fixes for fsl_sai driver
Date: Fri, 18 Jul 2014 02:38:06 +0000
Message-ID: <9e28b763e864442baccf0f45d975ef51@BN1PR0301MB0609.namprd03.prod.outlook.com>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
In-Reply-To: <cover.1405603108.git.nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Nicolin Chen [mailto:nicoleotsuka@gmail.com]
> Sent: Thursday, July 17, 2014 9:22 PM
> To: broonie@kernel.org
> Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; alsa-
> devel@alsa-project.org; timur@tabi.org; Xiubo Li-B47053; Wang Shengjiu-B0=
2247;
> Chen Guangyu-B42378
> Subject: [PATCH 0/2] ASoC: fsl_sai: Two bug fixes for fsl_sai driver
>=20
> Nicolin Chen (2):
>   ASoC: fsl_sai: Reset FIFOs after disabling TE/RE
>   ASoC: fsl_sai: Fix incorrect register writing in fsl_sai_isr()
>=20

Yes, they are all looks good to me.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>

Thanks,

BRs
Xiubo


>  sound/soc/fsl/fsl_sai.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> --
> 1.8.4
