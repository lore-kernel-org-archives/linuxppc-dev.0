Return-Path: <John.Linn@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 30D62B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 17:18:44 +1000 (EST)
Received: from IE1EHSOBE001.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 7172DDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 17:18:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] net: add Xilinx emac lite device driver
Date: Wed, 19 Aug 2009 01:13:16 -0600
In-Reply-To: <20090818.232815.73515404.davem@davemloft.net>
References: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
	<20090818.232815.73515404.davem@davemloft.net>
From: John Linn <John.Linn@xilinx.com>
To: "David Miller" <davem@davemloft.net>
Message-ID: <20090819071836.796AD185004B@mail145-dub.bigfish.com>
Cc: michal.simek@petalogix.com, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks David, I may have got over zealous in my clean up to get it ready
for mainline.

I'll take care of that.

-- John

> -----Original Message-----
> From: David Miller [mailto:davem@davemloft.net]
> Sent: Wednesday, August 19, 2009 7:28 AM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
jgarzik@pobox.com; grant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com; john.williams@petalogix.com;
michal.simek@petalogix.com; Sadanand Mutyala
> Subject: Re: [PATCH] net: add Xilinx emac lite device driver
> =

> From: John Linn <john.linn@xilinx.com>
> Date: Tue, 18 Aug 2009 09:30:41 -0600
> =

> > @@ -1926,6 +1926,11 @@ config ATL2
> >  	  To compile this driver as a module, choose M here.  The module
> >  	  will be called atl2.
> >
> > +config XILINX_EMACLITE
> > +	tristate "Xilinx 10/100 Ethernet Lite support"
> > +	help
> > +	  This driver supports the 10/100 Ethernet Lite from Xilinx.
> > +
> >  source "drivers/net/fs_enet/Kconfig"
> >
> >  endif # NET_ETHERNET
> =

> You can't unconditionally enable this driver everywhere.
> It depends upon things like openfirmware support, etc.
> so the driver will fail to link if the architecture doesn't
> have those support routines.
> =

> Please fix this up, thanks.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
