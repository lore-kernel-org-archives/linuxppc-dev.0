Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 26EC0DDEE9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 18:31:00 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 068D1F4914F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:30:59 +0100 (CET)
Subject: Re: [PATCH v2] using mii-bitbang on different processor ports
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <472776AE.2060009@freescale.com>
References: <1193767812.6244.46.camel@p60635-ste.ids.de>
	<472776AE.2060009@freescale.com>
Date: Wed, 31 Oct 2007 08:30:58 +0100
Message-Id: <1193815858.2678.2.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Dienstag, den 30.10.2007, 13:23 -0500 schrieb Scott Wood:
> Sergej Stepanov wrote:
> > +	if( !of_address_to_resource(np, 1, &res[1])) {
>=20
> The spacing is still wrong.
>=20
> > -	iounmap(bitbang->dir);
> > +	if ( bitbang->mdio.dir !=3D bitbang->mdc.dir)
> > +		iounmap(bitbang->mdio.dir);
> > +	iounmap(bitbang->mdc.dir);
>=20
> And here.
>=20
> -Scott
Oh, sorry.
--=20
Sergej I. Stepanov
E-PA
IDS GmbH
Nobelstr. 18, Zim. 2.1.05
D-76275 Ettlingen
T +49 (0) 72 43/2 18-615
F +49 (0) 72 43/2 18-400
Email: <Sergej.Stepanov@ids.de>

<http://www.ids.de>
Gesch=C3=A4ftsf=C3=BChrer: Norbert Wagner, Friedrich Abri=C3=9F=20
Sitz der Gesellschaft: Ettlingen=20
Amtsgericht Mannheim HRB 362503
