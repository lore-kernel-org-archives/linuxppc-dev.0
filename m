Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryXMk4yXjzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 17:05:38 +1000 (AEST)
Message-ID: <1469430327.25630.74.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Qiang Zhao <qiang.zhao@nxp.com>, Jason Cooper <jason@lakedaemon.net>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "marc.zyngier@arm.com"
 <marc.zyngier@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>
Date: Mon, 25 Jul 2016 02:05:27 -0500
In-Reply-To: <AM3PR04MB1185B0A04FC6879C2550A8EC910D0@AM3PR04MB1185.eurprd04.prod.outlook.com>
References: <1467854635-19208-1-git-send-email-qiang.zhao@nxp.com>
 <20160707142458.GN3348@io.lakedaemon.net>
 <AM3PR04MB1185B0A04FC6879C2550A8EC910D0@AM3PR04MB1185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2] irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-07-25 at 06:15 +0000, Qiang Zhao wrote:
> On Thu, Jul 07, 2016 at 10:25PM , Jason Cooper <jason@lakedaemon.net> wrote:
> > 
> > -----Original Message-----
> > From: Jason Cooper [mailto:jason@lakedaemon.net]
> > Sent: Thursday, July 07, 2016 10:25 PM
> > To: Qiang Zhao <qiang.zhao@nxp.com>
> > Cc: oss@buserror.net; tglx@linutronix.de; marc.zyngier@arm.com; linuxppc-
> > dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Xiaobo Xie
> > <xiaobo.xie@nxp.com>
> > Subject: Re: [PATCH v2] irqchip/qeic: move qeic driver from
> > drivers/soc/fsl/qe
> > 
> > Hi Zhao Qiang,
> > 
> > On Thu, Jul 07, 2016 at 09:23:55AM +0800, Zhao Qiang wrote:
> > > 
> > > The driver stays the same.
> > > 
> > > Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> > > ---
> > > Changes for v2:
> > > 	- modify the subject and commit msg
> > > 
> > >  drivers/irqchip/Makefile                | 1 +
> > >  drivers/{soc/fsl/qe => irqchip}/qe_ic.c | 0  drivers/{soc/fsl/qe =>
> > > irqchip}/qe_ic.h | 0
> > >  drivers/soc/fsl/qe/Makefile             | 2 +-
> > >  4 files changed, 2 insertions(+), 1 deletion(-)  rename
> > > drivers/{soc/fsl/qe => irqchip}/qe_ic.c (100%)  rename
> > > drivers/{soc/fsl/qe => irqchip}/qe_ic.h (100%)
> > Please merge the include file into the C file and rename to follow the
> > naming
> > convention in drivers/irqchip/.  e.g. irq-qeic.c or irq-qe_ic.c.
> > 
> > Once you have that, please resend the entire series with this as the first
> > patch.
> Sorry, I have no idea about "Include file", could you explain which file you
> meant?


qe_ic.h

If nothing else is going to include that, then the contents can go directly
into qe_ic.c.

-Scott
