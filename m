Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Move cpu hotplug driver lock from pseries to powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4B4F760C.4000507@austin.ibm.com>
References: <4B4F760C.4000507@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-7X5OEoctQYmYTv+l1sW+"
Date: Fri, 15 Jan 2010 10:39:20 +1100
Message-ID: <1263512360.31729.251.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-7X5OEoctQYmYTv+l1sW+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-01-14 at 13:52 -0600, Nathan Fontenot wrote:
> Move the defintion and lock helper routines for the cpu hotplug driver
> lock from pseries to powerpc code to avoid build breaks for platforms=20
> other than pseries that use cpu hotplug.
>=20
> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c              |   12 ++++++++++++
>  arch/powerpc/platforms/pseries/dlpar.c |   12 ------------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Much nicer :)

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers


--=-7X5OEoctQYmYTv+l1sW+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktPqygACgkQdSjSd0sB4dK1ogCgywh8GqHiPQnMWf5ft9tBClRK
B3YAn1Kpa5LwKjryQhQ3lq9cWXO9mjC0
=VBy/
-----END PGP SIGNATURE-----

--=-7X5OEoctQYmYTv+l1sW+--
