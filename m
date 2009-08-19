Return-Path: <John.Linn@xilinx.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 282EBB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 17:36:51 +1000 (EST)
Received: from SG2EHSOBE004.bigfish.com (sg2ehsobe004.messaging.microsoft.com
	[207.46.51.78]) by ozlabs.org (Postfix) with ESMTP id D061CDDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 17:36:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] net: add Xilinx emac lite device driver
Date: Wed, 19 Aug 2009 01:20:48 -0600
In-Reply-To: <20090818140418.347cb8ac@nehalam>
References: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
	<20090818140418.347cb8ac@nehalam>
From: John Linn <John.Linn@xilinx.com>
To: "Stephen Hemminger" <shemminger@vyatta.com>
Message-ID: <20090819072151.E2F681A0046@mail25-sin.bigfish.com>
Cc: Michal Simek <michal.simek@petalogix.com>, netdev@vger.kernel.org,
	Sadanand Mutyala <sadanan@xilinx.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, davem@davemloft.net,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@vyatta.com]
> Sent: Tuesday, August 18, 2009 10:04 PM
> To: John Linn
> Cc: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
jgarzik@pobox.com; davem@davemloft.net; John
> Linn; grant.likely@secretlab.ca; Josh Boyer; John Williams; Michal
Simek; Sadanand Mutyala
> Subject: Re: [PATCH] net: add Xilinx emac lite device driver
> =

> On Tue, 18 Aug 2009 09:30:41 -0600
> John Linn <john.linn@xilinx.com> wrote:
> =

> > +/**
> > + * xemaclite_enable_interrupts - Enable the interrupts for the
EmacLite device
> > + * @drvdata:	Pointer to the Emaclite device private data
> > + *
> > + * This function enables the Tx and Rx interrupts for the Emaclite
device along
> > + * with the Global Interrupt Enable.
> > + */
> > +static void xemaclite_enable_interrupts(struct net_local *drvdata)
> =

> Docbook format is really a not necessary on local functions that
> are only used in the driver.  It is fine if you want to use it, as
> long as the file isn't processed by kernel make docs but
> the docbook is intended for automatic generation of kernel API
manuals.

Thanks, we realize that and have been consistent with our drivers in
that area. We aren't adding them to the make for the docs so it doesn't
seem like it should be a problem. =


> =

> --


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
