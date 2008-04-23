Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] MSI driver for Freescale 83xx/85xx/86xx cpu
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <e642c15622ac3ca89a6a43f439f2c222@kernel.crashing.org>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208758907.9955.4.camel@concordia>
	<CC27DED0F8F39E48A7E75FD768688B7A874E57@zch01exm27.fsl.freescale.net>
	<1208838916.12660.10.camel@concordia.ozlabs.ibm.com>
	<e642c15622ac3ca89a6a43f439f2c222@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RBT0dD8wP4m1LbWSKBO1"
Date: Wed, 23 Apr 2008 15:45:45 +1000
Message-Id: <1208929545.9212.12.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Jin Zhengxiong <Jason.Jin@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RBT0dD8wP4m1LbWSKBO1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-04-22 at 15:22 +0200, Segher Boessenkool wrote:
> >>>> +static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
> >>>> +				  struct msi_msg *msg)
>=20
> > No I mean I'm confused about the maths here. If we pull out the
> > variables it boils down to:
> >
> > data =3D ((hwirq / 32) << 5) | ((hwirq % 32) & 0x1F)
> >
> > Which doesn't seem to actually do anything?
>=20
> It's not a no-op, because hwirq is signed.  It probably should be
> unsigned, like most things.

You'll have to draw me a picture.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-RBT0dD8wP4m1LbWSKBO1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDs0JdSjSd0sB4dIRAhQVAJ9dzxyEirtGx4caQRZmkN1wUa/CAQCgp4on
COiMasFLxM+p169G6U+AAw4=
=I/r4
-----END PGP SIGNATURE-----

--=-RBT0dD8wP4m1LbWSKBO1--
