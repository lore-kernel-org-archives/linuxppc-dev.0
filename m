Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RFC:  replace device_type with new "class" property?
Date: Mon, 29 Oct 2007 13:20:35 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3035F253D@az33exm25.fsl.freescale.net>
In-Reply-To: <47263800.8020401@freescale.com>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>	<4725FA58.4030505@genesi-usa.com><20071029172724.11354.qmail@farnsworth.org>	<47262E36.4030503@genesi-usa.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
	<47263800.8020401@freescale.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>
Cc: Linuxppc-dev@ozlabs.org
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
> From: Wood Scott-B07421=20
> Sent: Monday, October 29, 2007 2:44 PM
> To: Yoder Stuart-B08248
> Cc: Matt Sealey; Dale Farnsworth; Linuxppc-dev@ozlabs.org
> Subject: Re: RFC: replace device_type with new "class" property?
>=20
> Yoder Stuart-B08248 wrote:
> > Here's an example of what I'm trying to get at-- take=20
> > a node from a FSL device tree.  The ideas I've heard
> > for expressing the class are like this--
> >=20
> > #1  don't express any class at all:
> >=20
> >   ucc@2200 {
> >         compatible =3D "fsl,ucc_geth";
> >         model =3D "UCC";
> >         device-id =3D <3>;
> >         reg =3D <2200 200>;
> >         interrupts =3D <22>;
> >         interrupt-parent =3D < &qeic >;
> >         mac-address =3D [ 00 00 00 00 00 00 ];
> >         local-mac-address =3D [ 00 00 00 00 00 00 ];
> >         rx-clock =3D <19>;
> >         tx-clock =3D <1a>;
> >         phy-handle =3D < &phy3 >;
> >         pio-handle =3D < &pio3 >;
>=20
> Of course, this should properly be something like
>=20
> ethernet@2200 {
> 	compatible =3D "fsl,mpc8360-qe-enet", "fsl,qe-enet";
> 	local-mac-address =3D [ 00 00 00 00 00 00 ];
> 	...
> };
>=20
> With no "mac-address", and a more useful "model" if any at all.

That's fine, but as a human reader there is nothing
that would tell me this node implemented a defined
binding that specified required properties.

Stuart
