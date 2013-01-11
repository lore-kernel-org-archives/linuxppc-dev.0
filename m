Return-Path: <r58472@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05D662C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 20:24:25 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: "balbi@ti.com" <balbi@ti.com>, Chen Peter-B29397 <B29397@freescale.com>,
 Mehresh Ramneek-B31383 <B31383@freescale.com>
Subject: RE: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Date: Fri, 11 Jan 2013 09:24:16 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F09526C23@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111082731.GA11085@arwen.pp.htv.fi>
 <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111084129.GB11085@arwen.pp.htv.fi>
In-Reply-To: <20130111084129.GB11085@arwen.pp.htv.fi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Friday, January 11, 2013 4:41 PM
> To: Chen Peter-B29397
> Cc: balbi@ti.com; kernel@pengutronix.de; Li Yang-R58472; Greg KH; linux-
> usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
> current v3.8-rc3
>=20
> Hi,
>=20
> On Fri, Jan 11, 2013 at 08:35:29AM +0000, Chen Peter-B29397 wrote:
> > > > I am working on it, but there are two versions, this one and
> chipidea's.
> > > >
> > > > Anyway, I will send a patch to fix this problem.
> > >
> > > if you're already using chipidea, then send me a patch removing this
> > > driver and focus your effort on chipidea.
> > >
> > Added Sascha
> >
> > Now, not all of FSL i.mx USB can move to use chipidea due to some
> > platform and USB PHY problem.
>=20
> then we need to target fixing those problems and moving to chipidea
> completely at some point. There's no reason to duplicate efforts if we
> already have a re-usable driver in tree, right ?
>=20
> Let's fix this build break and focus on making sure all i.MX platforms
> can use chipidea so we can drop fsl udc on next merge window. That would
> be a great patchset to see.

I do agree that we need move to use the chipidea driver and eventually remo=
ve the fsl udc driver, but there were many users of the current driver such=
 as PowerPC and Coldfire platforms besides the i.MX platforms.  The support=
 for them with chipidea driver could also be broken for now.  I would sugge=
st to have a transitional period that both drivers are kept while new devel=
opment be based on the new driver.

Added Ramneek.  What do you think of the current status for chipidea driver=
 on PowerPC platforms?

Regards,
Leo
