Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FE1D2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 12:31:46 +1100 (EST)
Date: Tue, 15 Jan 2013 09:31:31 +0800
From: Peter Chen <peter.chen@freescale.com>
To: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130115013130.GA16514@nchen-desktop>
References: <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
 <20130114174054.GB12611@arwen.pp.htv.fi>
 <50F4464E.7000605@pengutronix.de>
 <20130114175724.GD12611@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <20130114175724.GD12611@arwen.pp.htv.fi>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 14, 2013 at 07:57:24PM +0200, Felipe Balbi wrote:
> On Mon, Jan 14, 2013 at 06:54:22PM +0100, Marc Kleine-Budde wrote:
> > On 01/14/2013 06:40 PM, Felipe Balbi wrote:
> > > Hi,
> > >=20
> > > On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:
> > >=20
> > > <snip>
> > >=20
> > >>>> Usually there isn't any Changelog between IP cores used in the d=
ifferent
> > >>>> fsl processors (at least available outside of fsl), that makes i=
t quite
> > >>>> difficult to say if something found on one imx is really the sam=
e as on
> > >>>> the other one. And they (usually) don't provide any versioning
> > >>>> information in a register or the documentation.
> > >>>>
> > >>>> just my 2=A2
> > >>>
> > >>> $SUBJECT is trying to differentiate a single feature (or maybe tw=
o) to
> > >>> replace cpu_is_xxx(), then expose that on driver_data without cre=
ating
> > >>> one enum value for each release from fsl.
> > >>
> > >> Felipe, every one or two SoCs may have their special operations fo=
r
> > >> integrate PHY interface, clk operation, or workaround for IC
> > >> limitation.
> > >=20
> > > the particular PHY and clk used should be hidden by phy layer and c=
lk
> > > API respectively. Workarounds, fair enough, we need to handle them;=
 but
> > > ideally those should be based on runtime revision detection, not so=
me
> > > hackery using driver_data.
> >=20
> > If this is actually possible, I'd love to do this. But IP vendor don'=
t
> > include a version register in their cores. :(
>=20
> then fair enough, driver_data or platform_data is the way to go, still
> my point (a) below is valid.
I will send v5 patch with your suggestion.

>=20
> --=20
> balbi



--=20

Best Regards,
Peter Chen
