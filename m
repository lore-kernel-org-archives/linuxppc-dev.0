Return-Path: <B29397@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E66B2C01C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 19:35:38 +1100 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: "balbi@ti.com" <balbi@ti.com>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>
Subject: RE: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Date: Fri, 11 Jan 2013 08:35:29 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803D63DA7@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
 <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
 <20130111082731.GA11085@arwen.pp.htv.fi>
In-Reply-To: <20130111082731.GA11085@arwen.pp.htv.fi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > >
> >
> > I am working on it, but there are two versions, this one and chipidea's=
.
> >
> > Anyway, I will send a patch to fix this problem.
>=20
> if you're already using chipidea, then send me a patch removing this
> driver and focus your effort on chipidea.
>=20
Added Sascha

Now, not all of FSL i.mx USB can move to use chipidea due to some platform =
and USB
PHY problem.

> --
> balbi
