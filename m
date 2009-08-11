Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3AE94B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 00:02:34 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A59D7DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 00:02:31 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7BE2BO5019954
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 07:02:22 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n7BE2neV029716
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 09:02:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [v3][PATCH][powerpc/85xx] P2020RDB Platform Support Added
Date: Tue, 11 Aug 2009 19:32:05 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF0951934F0@zin33exm24.fsl.freescale.net>
In-Reply-To: <BAFDE07A-DC01-46A5-A36E-7F8FB508CBFD@kernel.crashing.org>
References: <1249659316-22927-1-git-send-email-poonam.aggrwal@freescale.com>
	<BAFDE07A-DC01-46A5-A36E-7F8FB508CBFD@kernel.crashing.org>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Tuesday, August 11, 2009 7:11 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [v3][PATCH][powerpc/85xx] P2020RDB Platform Support Added
>=20
>=20
> On Aug 7, 2009, at 10:35 AM, Poonam Aggrwal wrote:
>=20
> >
> > +		enet2: ethernet@26000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +			cell-index =3D <2>;
> > +			device_type =3D "network";
> > +			model =3D "eTSEC";
> > +			compatible =3D "gianfar";
> > +			reg =3D <0x26000 0x1000>;
> > +			ranges =3D <0x0 0x26000 0x1000>;
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			interrupts =3D <31 2 32 2 33 2>;
> > +			interrupt-parent =3D <&mpic>;
> > +			phy-handle =3D <&phy1>;
> > +			phy-connection-type =3D "rgmii-id";
> > +		};
>=20
> was there an answer to why we don't have an mdio node for enet2?
>=20
Yes I already replied to it, actually the enet2 (eTSEC3) on RDB is only
exposed as RGMII, and the mdio lines it will use is those of enet0. In
case it also could be configured in SGMII(as in P2020DS), then we would
have needed the mdio node for enet2 to configure the TBI PHY.=20
> - k
>=20
