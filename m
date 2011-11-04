Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: fpga driver on custom PPC target platform (P4080) ...
Date: Fri, 4 Nov 2011 14:19:36 -0400
Message-ID: <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Robert Sciuk" <robert.sciuk@exfo.com>,
 "Tabi Timur-B04825" <B04825@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> > I *believe* you are not supposed to create separate nodes for =
reading
> > and writing.  I know that's how I2C works, but I think the I2C layer
> > takes care of that for you.
> >
> > If you look at other device trees, you'll see they only have one =
node
> > for any particular I2C device.
> >
> > --
> > Timur Tabi
> > Linux kernel developer at Freescale
>=20
>=20
> Thanks, Timur ... I've fixed the tree, and I'm tracking down the
> problems with addressing the nodes ...

Ah,  my compatible attribute was wrong:

	Compatible =3D "nxp,pca9539";

	Should have been:

	Compatible =3D "nxp,pca953x";

The tree now seems to bind the i2c gpio drivers properly ... on to the =
localbus mappings!

Rob.
