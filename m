Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7BFE0DDE19
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 14:21:34 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m113LTZO023936
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 20:21:29 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m113LRsI006873
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 21:21:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/2] Add RapidIO node into MPC8641HPCN dts file
Date: Fri, 1 Feb 2008 11:21:26 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD089C@zch01exm26.fsl.freescale.net>
In-Reply-To: <47A1FEB4.1040806@freescale.com>
References: <12017656032841-git-send-email-wei.zhang@freescale.com>
	<47A1FEB4.1040806@freescale.com>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Loeliger Jon" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Loeliger Jon=20
>=20
> Zhang Wei wrote:
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts=20
> b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > index 556a9ca..1a0fce5 100644
> > --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>=20
> > @@ -499,4 +500,16 @@
> >  				  0 00100000>;
> >  		};
> >  	};
> > +
> > +	rapidio0: rapidio@f80c0000 {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		compatible =3D "fsl,rapidio-delta";
> > +		reg =3D <f80c0000 20000>;
> > +		ranges =3D <0 0 c0000000 0 20000000>;
> > +		interrupt-parent =3D <&mpic>;
> > +		/* err_irq bell_outb_irq bell_inb_irq
> > +			msg1_tx_irq msg1_rx_irq	msg2_tx_irq=20
> msg2_rx_irq */
> > +		interrupts =3D <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
> > +	};
> >  };
>=20
> Have updates to the booting-without-of.txt file for
> been made or proposed for the RapidIO node definition?
>=20
I remember Kumar has a patch for RapidIO node of booting-without-of.txt, =
is it?

Cheers!
Wei.
