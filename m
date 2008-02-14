Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 87E57DDF98
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:33:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Enable correct operation of serial ports
	withnonzero regshift.
Date: Thu, 14 Feb 2008 15:33:09 -0800
In-Reply-To: <20080215102706.1b7c30c1.sfr@canb.auug.org.au>
References: <47B35ED8.7020404@ru.mvista.com><20080214185534.81F625F808D@mail186-dub.bigfish.com>
	<20080215102706.1b7c30c1.sfr@canb.auug.org.au>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Message-Id: <20080214233311.B01D7AD8050@mail122-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


gcc knows better. :)

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Thursday, February 14, 2008 3:27 PM
> To: Stephen Neuendorffer
> Cc: Pavel Kiryukhin; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] [POWERPC] Enable correct operation of serial
ports withnonzero regshift.
>=20
> On Thu, 14 Feb 2008 10:55:31 -0800 "Stephen Neuendorffer"
<stephen.neuendorffer@xilinx.com> wrote:
> >
> > > --- a/arch/powerpc/kernel/legacy_serial.c
> > > +++ b/arch/powerpc/kernel/legacy_serial.c
> > > +	/* get regshift if present*/
> > > +	regshift =3D get_property(np, "reg-shift", NULL);
> >
> > of_get_property, presumably?
>=20
> Damn, how did I miss that?  :-)
>=20
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
