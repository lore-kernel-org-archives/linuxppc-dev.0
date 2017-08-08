Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0076.outbound.protection.outlook.com [104.47.0.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPRh5XDvzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:21:20 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "tglx@linutronix.de"
 <tglx@linutronix.de>
CC: "oss@buserror.net" <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
Date: Tue, 8 Aug 2017 06:21:12 +0000
Message-ID: <AM3PR04MB1185747366C53DCC51A8A88F918A0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1502075236-24078-1-git-send-email-qiang.zhao@nxp.com>
 <1502075236-24078-5-git-send-email-qiang.zhao@nxp.com>
 <87h8xjq2rw.fsf@concordia.ellerman.id.au>
In-Reply-To: <87h8xjq2rw.fsf@concordia.ellerman.id.au>
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

On Mon 8/7/2017 3:02 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Monday, August 07, 2017 3:02 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>; tglx@linutronix.de
> Cc: oss@buserror.net; Qiang Zhao <qiang.zhao@nxp.com>; linuxppc-
> dev@lists.ozlabs.org; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v10 4/4] irqchip/qeic: remove PPCisms for QEIC
>=20
> Zhao Qiang <qiang.zhao@nxp.com> writes:
>=20
> > QEIC was supported on PowerPC, and dependent on PPC, Now it is
> > supported on other platforms, so remove PPCisms.
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> >  arch/powerpc/platforms/83xx/km83xx.c          |   1 -
> >  arch/powerpc/platforms/83xx/misc.c            |   1 -
> >  arch/powerpc/platforms/83xx/mpc832x_mds.c     |   1 -
> >  arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   1 -
> >  arch/powerpc/platforms/83xx/mpc836x_mds.c     |   1 -
> >  arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   1 -
> >  arch/powerpc/platforms/85xx/corenet_generic.c |   1 -
> >  arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   1 -
> >  arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   1 -
> >  arch/powerpc/platforms/85xx/twr_p102x.c       |   1 -
> >  drivers/irqchip/irq-qeic.c                    | 188 +++++++++++-------=
--------
> >  include/soc/fsl/qe/qe_ic.h                    | 132 ------------------
> >  12 files changed, 80 insertions(+), 250 deletions(-)  delete mode
> > 100644 include/soc/fsl/qe/qe_ic.h
> >
> > diff --git a/arch/powerpc/platforms/83xx/km83xx.c
> > b/arch/powerpc/platforms/83xx/km83xx.c
> > index d8642a4..b1cef0a 100644
> > --- a/arch/powerpc/platforms/83xx/km83xx.c
> > +++ b/arch/powerpc/platforms/83xx/km83xx.c
> > @@ -38,7 +38,6 @@
> >  #include <sysdev/fsl_soc.h>
> >  #include <sysdev/fsl_pci.h>
> >  #include <soc/fsl/qe/qe.h>
> > -#include <soc/fsl/qe/qe_ic.h>
>=20
> You deleted that file in patch 2. So didn't you just break the build for =
the last two
> commits?

Sorry, I am not sure what you said. Could you explain?
Thank you!

BR
Qiang Zhao
