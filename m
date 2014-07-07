Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D805D1A0009
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jul 2014 20:27:01 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [3/3,v4] powerpc/t2080rdb: Add T2080RDB board support
Date: Mon, 7 Jul 2014 10:26:53 +0000
Message-ID: <8f75541b111b44e3a26e2f6f4dc9df77@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1402481406-10830-3-git-send-email-Shengzhou.Liu@freescale.com>
 <20140625233450.GA13860@home.buserror.net>
In-Reply-To: <20140625233450.GA13860@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, June 26, 2014 7:35 AM
> To: Liu Shengzhou-B36685
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [3/3,v4] powerpc/t2080rdb: Add T2080RDB board support
>=20
> On Wed, Jun 11, 2014 at 06:10:06PM +0800, Shengzhou Liu wrote:
> > +				i2c@0 {
> > +					#address-cells =3D <1>;
> > +					#size-cells =3D <0>;
> > +					reg =3D <0x0>;
> > +
> > +					sfp@50 {
> > +						compatible =3D "optics,sfp";
> > +						reg =3D <0x50>;
> > +					};
> > +				};
>=20
> What is "sfp"?  Please use generic node names when possible.
>=20
> I'm not able to easily find what chip this is referring to by googling
> "optics sfp".  I suspect this compatible is too vague -- what is the
> actual part number?  Could you provide a URL to a description of the chip=
?
>=20
> If "optics" is the correct vendor name, it needs to go into vendor-prefix=
es.txt.
>=20
> -Scott
[Shengzhou] SFP is "Small Form-factor Pluggable transceiver" for 10Gpbs opt=
ics module.  Actually, there is no a specific vendor for this case, it is a=
 general sfp cage to which we can plug in different optics module from diff=
erent vendors.  And there is no need to configure it by SW. =20
