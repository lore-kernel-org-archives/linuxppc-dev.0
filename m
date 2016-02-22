Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE8261A075A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 20:39:36 +1100 (AEDT)
Message-ID: <1456133962.15241.62.camel@decadent.org.uk>
Subject: Re: powerpc/mm: Fix HAVE_ARCH_SOFT_DIRTY dependencies
From: Ben Hutchings <ben@decadent.org.uk>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 22 Feb 2016 09:39:22 +0000
In-Reply-To: <20160222082400.4B585140C3B@ozlabs.org>
References: <20160222082400.4B585140C3B@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Olsc5MuuttYQTjubOOKa"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Olsc5MuuttYQTjubOOKa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-02-22 at 19:24 +1100, Michael Ellerman wrote:
> On Sat, 2016-20-02 at 17:58:37 UTC, Ben Hutchings wrote:
> > Soft dirty bit support was only implemented for 64-bit Book3S, and
> > 32-bit configurations currently fail to build.
> >=20
> > Fixes: 7207f43665b8 ("powerpc/mm: Add page soft dirty tracking")
> > References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dpowerpc&ver=3D4.5%7Erc4-1%7Eexp1&stamp=3D1455791718
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>=20
> Thanks for the patch Ben.
>=20
> I merged a similar but not identical patch into my fixes branch last week=
, and
> Linus merged it over the weekend. Let me know if it isn't sufficient for =
you:
>=20
> =C2=A0 https://git.kernel.org/torvalds/c/19f97c983071

Yes that works, thanks.

Ben.

--=20
Ben Hutchings
The generation of random numbers is too important to be left to chance.
                                                            - Robert Coveyo=
u
--=-Olsc5MuuttYQTjubOOKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAVsrXSue/yOyVhhEJAQpxUg//RAjEXiBHLbJa5QWwyinofQnDwT60GHJk
rtTRn6NowbMtLRo56mWa950p6AHIgo54yXTx8LSs8p5Hh3+/oPnn5NNQ+CVk9DsE
CpNO1E7cbAOVl1Nm4+vA0+DqnEH0aXPL/Af4su0BzYNVy0L/PvsEdok86NpOaQli
bmjtNigiL1B0RhxMyEZciH3cmmf70goc3m5BIfx0WCSDTyf7EXxWgnOXMcw26Qkg
CpoTKcS/KHdbp5v2yUDhJpp6kmCii5hjSwYpc8+dq65Etnr6923GeQpbcx4L/0qH
wDe3sDzgd3swovHvxlEmgPiVzhA58K+PMy+rft6NVg7Wt1tHZ8f1pgOuImAocSEq
sY8brpqYikD/oRtN3ZbNAZrEXniGiFQpxPy6x3l7YvniHCaZYQLkO7Cl8fDjlhvd
qlHAP68t9cuhUfW90xEKM8M292dDVyzl1si3raM6CeA5XQGrNJsz8T+1Laq98Ln+
2Dk1kgg+vEBO5a+/qaj4di2qoSMARlHyTytls0NR+M8aEmTVSsnx4JpbegPpiiCY
DnvYmsbDQje757z2z+HbljSVbJD1tJBRywqVZM0CgA5QBVx5AOjBpXHdlqpUjqR4
EXxK73O8bZzSQNX/kbOVanqOTrvm6dXiI+B10i7B71y4FvDgN7f6MgHMn0QcwPWH
mT05Jq9TRUo=
=88VX
-----END PGP SIGNATURE-----

--=-Olsc5MuuttYQTjubOOKa--
