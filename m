Return-Path: <r58472@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9AC022C00F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 14:22:01 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Chen Peter-B29397 <B29397@freescale.com>, Greg KH
 <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>
Subject: RE: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on current
 v3.8-rc3
Date: Fri, 11 Jan 2013 03:21:51 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F09526763@039-SN2MPN1-023.039d.mgd.msft.net>
References: <20130110100835.GB28920@arwen.pp.htv.fi>
 <20130110143006.GC15787@kroah.com>
In-Reply-To: <20130110143006.GC15787@kroah.com>
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

> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, January 10, 2013 10:30 PM
> To: Felipe Balbi
> Cc: Li Yang-R58472; linux-usb@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [BUILD BREAK] usb: gadget: fsl_mxc_udc can't compile on
> current v3.8-rc3
>=20
> On Thu, Jan 10, 2013 at 12:08:35PM +0200, Felipe Balbi wrote:
> > Hi,
> >
> > Some recent patch has caused fsl_mxc_udc.c driver to fail compilation
> > because it can't find <mach/hardware.h> anymore.
> >
> > I would like this to be fixed still during this -rc cycle.
>=20
> Me too, who's sending a patch?  :)

Hi Peter,

Who is currently working on the i.mx USB?

Regards,
Leo
