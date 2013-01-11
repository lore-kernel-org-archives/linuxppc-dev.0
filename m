Return-Path: <B29397@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CEDEF2C0131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 14:24:06 +1100 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>, Greg KH
 <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>
Subject: RE: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Date: Fri, 11 Jan 2013 03:23:59 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803D63ACE@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
 <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> > > Some recent patch has caused fsl_mxc_udc.c driver to fail compilation
> > > because it can't find <mach/hardware.h> anymore.
> > >
> > > I would like this to be fixed still during this -rc cycle.
> >
> > Me too, who's sending a patch?  :)
>=20
> Hi Peter,
>=20
> Who is currently working on the i.mx USB?
>=20

I am working on it, but there are two versions, this one and chipidea's.

Anyway, I will send a patch to fix this problem.

> Regards,
> Leo
