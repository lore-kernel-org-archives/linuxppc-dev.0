Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: fpga driver on custom PPC target platform (P4080) ...
Date: Mon, 7 Nov 2011 13:48:26 -0500
Message-ID: <2DD52030B5146141BEB762A11AE97C4C0100CB11@SPQCEXC05.exfo.com>
In-reply-to: <20111105004050.GA1384@truffala.fritz.box>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
 <20111105004050.GA1384@truffala.fritz.box>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Ah,  my compatible attribute was wrong:
> >
> > 	Compatible =3D "nxp,pca9539";
> >
> > 	Should have been:
> >
> > 	Compatible =3D "nxp,pca953x";
> >
> > The tree now seems to bind the i2c gpio drivers properly ... on to
> > the localbus mappings!
>=20
> Ah.  In that case the drivers should probably be extended to recognize
> the first compatible.  "wildcard" compatible strings are a bad idea,
> unfortunately there are some already in the wild, as you've seen.  We
> should try to phase them out though.
>=20
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_
> _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks, David

It did occur that a specific binding should be preferred over a generic =
one=20

Rob.
