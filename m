Return-Path: <qiang.zhao@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50043.outbound.protection.outlook.com [40.107.5.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJg7w6qJxzDrLS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 17:14:20 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>
CC: "valentin.longchamp@keymile.com" <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] qe: fix compile issue for arm64
Date: Fri, 28 Jul 2017 07:14:15 +0000
Message-ID: <AM3PR04MB118514C540F2A3FF383FC4AD91BF0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1500867555-36277-1-git-send-email-qiang.zhao@nxp.com>
 <87o9s5dr6n.fsf@concordia.ellerman.id.au>
In-Reply-To: <87o9s5dr6n.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fri 7/28/2017 2:14 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Friday, July 28, 2017 2:14 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
> Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
> Subject: Re: [PATCH v2] qe: fix compile issue for arm64
>=20
> Zhao Qiang <qiang.zhao@nxp.com> writes:
>=20
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2:
> > 	- include all Errata QE_General4 in #ifdef
> >
> >  drivers/soc/fsl/qe/qe.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> AFAICS this driver can only be built on PPC, what am I missing?
>=20
> config QUICC_ENGINE
>         bool "Freescale QUICC Engine (QE) Support"
>         depends on FSL_SOC && PPC32
>=20
> cheers

I sent another patchset to support it on arm64.
Thank you!=20

Best Regards
Qiang Zhao
