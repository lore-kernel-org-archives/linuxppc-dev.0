Return-Path: <qiang.zhao@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0053.outbound.protection.outlook.com [104.47.2.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlxwk4ZjPzDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 11:39:01 +1000 (AEST)
From: Qiang Zhao <qiang.zhao@nxp.com>
To: Jason Cooper <jason@lakedaemon.net>
CC: "oss@buserror.net" <oss@buserror.net>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie
 <xiaobo.xie@nxp.com>
Subject: RE: [PATCH v2] irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
Date: Fri, 8 Jul 2016 01:04:42 +0000
Message-ID: <AM3PR04MB11852A1ADDDA8E68D92CBEE3913C0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1467854635-19208-1-git-send-email-qiang.zhao@nxp.com>
 <20160707142458.GN3348@io.lakedaemon.net>
In-Reply-To: <20160707142458.GN3348@io.lakedaemon.net>
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

On Thu, Jul 07, 2016 at 10:25PM , Jason Cooper <jason@lakedaemon.net> wrote=
:
> -----Original Message-----
> From: Jason Cooper [mailto:jason@lakedaemon.net]
> Sent: Thursday, July 07, 2016 10:25 PM
> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> <xiaobo.xie@nxp.com>
> Subject: Re: [PATCH v2] irqchip/qeic: move qeic driver from drivers/soc/f=
sl/qe
>=20
> Hi Zhao Qiang,
>=20
> On Thu, Jul 07, 2016 at 09:23:55AM +0800, Zhao Qiang wrote:
> > The driver stays the same.
> >
> > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > ---
> > Changes for v2:
> > 	- modify the subject and commit msg
> >
> >  drivers/irqchip/Makefile                | 1 +
> >  drivers/{soc/fsl/qe =3D> irqchip}/qe_ic.c | 0  drivers/{soc/fsl/qe =3D=
>
> > irqchip}/qe_ic.h | 0
> >  drivers/soc/fsl/qe/Makefile             | 2 +-
> >  4 files changed, 2 insertions(+), 1 deletion(-)  rename
> > drivers/{soc/fsl/qe =3D> irqchip}/qe_ic.c (100%)  rename
> > drivers/{soc/fsl/qe =3D> irqchip}/qe_ic.h (100%)
>=20
> Please merge the include file into the C file and rename to follow the na=
ming
> convention in drivers/irqchip/.  e.g. irq-qeic.c or irq-qe_ic.c.
>=20
> Once you have that, please resend the entire series with this as the firs=
t patch.
>=20

OK, I will modify the next version.=20

-Zhao Qiang
BR
