Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Only disable/enable LSI interrupts in EEH
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Mason <mmlnx@us.ibm.com>
In-Reply-To: <4991EDB5.8070803@us.ibm.com>
References: <4990EF8B.7060203@us.ibm.com>  <4991EDB5.8070803@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-zDhxhZxOHo77akLTvgkV"
Date: Wed, 11 Feb 2009 10:39:41 +1100
Message-Id: <1234309181.8323.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zDhxhZxOHo77akLTvgkV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-02-10 at 13:12 -0800, Mike Mason wrote:
> I'm resubmitting this patch with a couple changes
> suggested by Michael Ellerman.  1) the new functions
> should be static, and 2) some people may object to
> including unrelated formating changes.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The EEH code disables and enables interrupts during the
> device recovery process.  This is unnecessary for MSI
> and MSI-X interrupts because they are effectively disabled
> by the DMA Stopped state when an EEH error occurs.  The
> current code is also incorrect for MSI-X interrupts.  It
> doesn't take into account that MSI-X interrupts are tracked
> in a different way than LSI/MSI interrupts.  This patch=20
> ensures only LSI interrupts are disabled/enabled.
>=20
> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>


Looks good. Assuming you've tested it :)

Acked-by: Michael Ellerman <michael@ellerman.id.au>


--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-zDhxhZxOHo77akLTvgkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSED0ACgkQdSjSd0sB4dIOhwCfWc+asxkLszbqAwXH5Xomx3mU
CqsAnilSo468iO34d9MAqJrGsWY/eLEL
=Hl6m
-----END PGP SIGNATURE-----

--=-zDhxhZxOHo77akLTvgkV--
