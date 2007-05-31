Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08B69DDFE0
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 15:54:08 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l4V5s3ON028583
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:54:03 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4V5s2pT006266
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 00:54:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Fix problems with Holly's DT representation of ethernet PHYs
Date: Thu, 31 May 2007 13:54:00 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E7ED9EF@zch01exm23.fsl.freescale.net>
In-Reply-To: <1180466979.3360.69.camel@zod.rchland.ibm.com>
References: <20070529060541.GG30266@localhost.localdomain><c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org><1180448346.3360.49.camel@zod.rchland.ibm.com><a5c459df2eefeb9261e65c551870f7f5@kernel.crashing.org>
	<1180466979.3360.69.camel@zod.rchland.ibm.com>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On Tue, 2007-05-29 at 16:49 +0200, Segher Boessenkool wrote:
> > >>> +			compatible =3D "tsi-mdio";
> > >>
> > >> Hrm, did I miss this before?  A more exact "compatible"
> > >> property would be better ("tsi109-mdio" "tsi108-mdio" or
> > >> something like that).
> > >
> > > If we must, then tsi108-mdio is what I would recommend. =20
> They are the
> > > same between 108, 109, and 110 as far as I know, so it's=20
> the lowest
> > > common denominator.
> >=20
> > [Assuming what is really on the board is a tsi109...]
>=20
> For Holly, yes.  For Taiga, it's 108.  For Hackberry, it's 110.

For Taiga, it's 108 or 109.
The new manufactured taiga board with 109 chip!
Roy
