Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2.6.26?] Raise the upper limit of NR_CPUS.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20080418053349.GE20457@bakeyournoodle.com>
References: <20080418053349.GE20457@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-asBtM8HVq9oVBJyGUBbD"
Date: Fri, 18 Apr 2008 20:33:44 +1000
Message-Id: <1208514829.8424.0.camel@concordia>
Mime-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-asBtM8HVq9oVBJyGUBbD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-04-18 at 15:33 +1000, Tony Breeds wrote:
> As the pacas are statically initialised increasing NR_CPUS beyond 128,
> means that any additional pacas will be empty  ... which is bad.
>=20
> This patch adds the required functionality to fill in any excess pacas
> at runtime.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
> I know it's late, but can this be considered for 2.6.26?
>=20
>  arch/powerpc/kernel/paca.c             |   33 ++++++++++----------------=
--
>  arch/powerpc/kernel/prom_init.c        |   36 ++++++++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/Kconfig.cputype |    4 +-
>  include/asm-powerpc/paca.h             |   19 ++++++++++++++++

What happens on non prom-init platforms?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-asBtM8HVq9oVBJyGUBbD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBICHkIdSjSd0sB4dIRAsDfAJ9wunbIAfdlMkLXc55XSssbzCWdwACbBSdL
WAVjlqPzHI6I4Df355ZiYR8=
=ZcuM
-----END PGP SIGNATURE-----

--=-asBtM8HVq9oVBJyGUBbD--
