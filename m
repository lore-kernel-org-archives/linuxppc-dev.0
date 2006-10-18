Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061012161845.GY4381@austin.ibm.com>
References: <1160654587.449977.520618728447.qpush@concordia>
	<20061012120310.6B5A967BD5@ozlabs.org>
	<20061012161845.GY4381@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-73OC6ioMe/i8bt+fhRNa"
Date: Wed, 18 Oct 2006 17:13:46 +1000
Message-Id: <1161155626.7906.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-73OC6ioMe/i8bt+fhRNa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-12 at 11:18 -0500, Linas Vepstas wrote:
> On Thu, Oct 12, 2006 at 10:03:08PM +1000, Michael Ellerman wrote:
> >=20
> >  arch/powerpc/platforms/cell/spu_base.c |    4=20
> >  arch/powerpc/xmon/xmon.c               |  142 ++++++++++++++++++++++++=
++++++++-
> >  include/asm-powerpc/xmon.h             |    2=20
> >  3 files changed, 146 insertions(+), 2 deletions(-)
>=20
> The next patch adds another 60 lines to xmon.c, which=20
> is already a bit too big. Perhaps you could instead
> put this code in "xmon/cell.c" or something like that?

I did originally, but that requires exporting several globals from
xmon.c, which struck me as even less pleasant.

I looked at some way of wrapping the if(setjmp) .. logic into a
function, but I couldn't come up with anything neat in the little time I
had.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-73OC6ioMe/i8bt+fhRNa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNdQpdSjSd0sB4dIRAjfiAJ0W+O93ahYOxUMFP4QUIZf43L06YQCfbMGg
OLzecU1naylXfVjmb1jukx0=
=0okG
-----END PGP SIGNATURE-----

--=-73OC6ioMe/i8bt+fhRNa--
