Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0058.outbound.protection.outlook.com [104.47.1.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMbtz69MTzDrL3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 11:58:19 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "oss@buserror.net"
 <oss@buserror.net>
CC: "valentin.longchamp@keymile.com" <valentin.longchamp@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: QRE: [PATCH v2] qe: fix compile issue for arm64
Date: Wed, 2 Aug 2017 01:58:13 +0000
Message-ID: <AM3PR04MB1185D321AD44C31C27ED2D6D91B00@AM3PR04MB1185.eurprd04.prod.outlook.com>
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


Michael Ellerman <mpe@ellerman.id.au> wrote:

> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Monday, July 31, 2017 6:37 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
> Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org
> Subject: RE: [PATCH v2] qe: fix compile issue for arm64
>=20
> Qiang Zhao <qiang.zhao@nxp.com> writes:
>=20
> > Fri 7/28/2017 2:14 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >> -----Original Message-----
> >> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> >> Sent: Friday, July 28, 2017 2:14 PM
> >> To: Qiang Zhao <qiang.zhao@nxp.com>; oss@buserror.net
> >> Cc: valentin.longchamp@keymile.com; linuxppc-dev@lists.ozlabs.org;
> >> linux- kernel@vger.kernel.org; Qiang Zhao <qiang.zhao@nxp.com>
> >> Subject: Re: [PATCH v2] qe: fix compile issue for arm64
> >>
> >> Zhao Qiang <qiang.zhao@nxp.com> writes:
> >>
> >> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> >> > ---
> >> > Changes for v2:
> >> > 	- include all Errata QE_General4 in #ifdef
> >> >
> >> >  drivers/soc/fsl/qe/qe.c | 2 ++
> >> >  1 file changed, 2 insertions(+)
> >>
> >> AFAICS this driver can only be built on PPC, what am I missing?
> >>
> >> config QUICC_ENGINE
> >>         bool "Freescale QUICC Engine (QE) Support"
> >>         depends on FSL_SOC && PPC32
> >>
> >> cheers
> >
> > I sent another patchset to support it on arm64.
>=20
> Where? I don't see it.
>=20
> Shouldn't this patch be part of that series? Otherwise when that series i=
s merged
> the build will break on arm64.
>=20
You are correct, thanks for your recommend.
I will add this patch to the patchset.

Thank you!

BR
Qiang Zhao
