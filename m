Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A6045DDFE9
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:51:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] booting-without-of: add Xilinx uart 16550.
Date: Fri, 15 Feb 2008 09:46:28 -0800
In-Reply-To: <47B5CEAF.8030705@ru.mvista.com>
References: <47B59631.10908@ru.mvista.com>
	<20080215170844.9D21610081@mail40-dub.bigfish.com>
	<47B5CEAF.8030705@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Pavel Kiryukhin" <pkiryukhin@ru.mvista.com>
Message-Id: <20080215174630.B35651B50078@mail211-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Pavel Kiryukhin [mailto:pkiryukhin@ru.mvista.com]
> Sent: Friday, February 15, 2008 9:41 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] booting-without-of: add Xilinx uart 16550.
>=20
> Stephen Neuendorffer wrote:
> >> +       - reg-shift : registers offset shift (standard uart_port
> > field).
> >> +         Property is optional if regshift is zero.
> >
> > I was hoping to get an idea of what is required here, or when I
might
> > use it?
> >
> > It looks like the ARCH=3Dppc code instantiates this with a reg-shift
of
> > 2...  Is this the expected value?
>=20
> Yes, reg-shift =3D 2 should be set for Xilinx 16550 uart.
> Should I add this to patch?

Yes, please!
=20
> BTW regshift=3D2 is hardcoded for uartlite.
>=20
> > When would it be not zero? or not
> > two?
> Sorry, it seems I don't follow here.

I think all that needs to get added is 'For the Xilinx uart 16550 cores,
reg-shift must be set to 2'

Steve
