Return-Path: <michael@ellerman.id.au>
Subject: Re: [openib-general] Can't build
	drivers/infiniband/hw/ipath/ipath_keys.c on arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Robert Walsh <rjwalsh@pathscale.com>
In-Reply-To: <454EE778.2030109@pathscale.com>
References: <1162798399.8175.24.camel@localhost.localdomain>
	<454EE778.2030109@pathscale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-znlZWRcCtw6Bd5ok4I8P"
Date: Mon, 06 Nov 2006 19:31:22 +1100
Message-Id: <1162801882.8175.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: support@pathscale.com, Andrew Morton <akpm@osdl.org>,
	openib-general <openib-general@openib.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-znlZWRcCtw6Bd5ok4I8P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-11-05 at 23:42 -0800, Robert Walsh wrote:
> Michael Ellerman wrote:
> > Hi,
> >=20
> > Just a heads-up, drivers/infiniband/hw/ipath/ipath_keys.c doesn't build
> > on powerpc because we have don't have bus_to_virt().
> >=20
> > (Actually you can't select CONFIG_INFINIBAND_IPATH on mainline because
> > powerpc doesn't enable PCI_MSI, but we will real soon now, and when we
> > do this will start breaking people's all modconfig builds).
>=20
> Thanks for the heads-up.  We're working to remove this requirement as we=20
> speak.

Sweet.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-znlZWRcCtw6Bd5ok4I8P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFTvLadSjSd0sB4dIRArR7AJ9jycH6iy5+Oy3XQl4UuNwDOGbxrgCdEQLA
SChE4hXsMdG63GLo46cR3w0=
=jm2s
-----END PGP SIGNATURE-----

--=-znlZWRcCtw6Bd5ok4I8P--
