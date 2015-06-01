Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C35761A0673
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 14:25:08 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xiaobo Xie
 <X.Xie@freescale.com>
Subject: RE: [v4] QE: Move QE from arch/powerpc to drivers/soc
Date: Mon, 1 Jun 2015 04:09:55 +0000
Message-ID: <SN1PR0301MB1550F0744C4F5B84D6B6DA9D9BB60@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1415763613-43674-1-git-send-email-B45475@freescale.com>
 <20150130052208.GA14431@home.buserror.net>
In-Reply-To: <20150130052208.GA14431@home.buserror.net>
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

On Fri, Jan 30, 2015 at 1:22PM +0800, Wood Scott wrote:

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, January 30, 2015 1:22 PM
> To: Zhao Qiang-B45475
> Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Wood Scott-B07421; Xie Xiaobo-R63061
> Subject: Re: [v4] QE: Move QE from arch/powerpc to drivers/soc
>=20
> On Wed, Nov 12, 2014 at 11:40:13AM +0800, Zhao Qiang wrote:
> > ls1 has qe and ls1 has arm cpu.
> > move qe from arch/powerpc to drivers/soc/fsl to adapt to powerpc and
> > arm
> >
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > Changes for v2:
> > 	- move code to driver/soc
> > Changes for v3:
> > 	- change drivers/soc/qe to drivers/soc/fsl-qe Changes for v4:
> > 	- move drivers/soc/fsl-qe to drivers/soc/fsl/qe
> > 	- move head files for qe from include/linux/fsl to include/soc/fsl
> > 	- move qe_ic.c to drivers/irqchip/
>=20
> Need MAINTAINERS update for drivers/soc/fsl/qe, as previously discussed.

You mean, I need to finish the following work before move qe to public dire=
ctory?

1. gpio.c -> needs to be converted to GPIO framework and placed in drivers/=
gpio
2. qe_ic* should probably move into drivers/irqchip
3. qe_io.c should be converted over to pinmux and put in drivers/pinctrl
4. Some of the clock could should be looked to be converted to use the clk =
framework

>=20
> -Scott


Best Regards
Zhao Qiang
