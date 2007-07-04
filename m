Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] Modify sched_clock() to make CONFIG_PRINTK_TIME
	more sane.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20070704040431.1A13432C46D@thor>
References: <20070704040431.1A13432C46D@thor>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-X5rH9bbMbDjVaukoX9EM"
Date: Wed, 04 Jul 2007 14:27:48 +1000
Message-Id: <1183523268.26479.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X5rH9bbMbDjVaukoX9EM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-07-04 at 14:04 +1000, Tony Breeds wrote:
> When booting a current kernel with CONFIG_PRINTK_TIME enabled you'll
> see messages like:
>=20
> [    0.000000] time_init: decrementer frequency =3D 188.044000 MHz
> [    0.000000] time_init: processor frequency   =3D 1504.352000 MHz
> [3712914.436297] Console: colour dummy device 80x25
>=20
> This cause by the initialisation of tb_to_ns_scale in time_init(), sudden=
ly the
> multiplication in sched_clock() now does something :).  This patch modifi=
es
> sched_clock() to report the offset since the machine booted so the same
> printk's now look like:
>=20
> [    0.000000] time_init: decrementer frequency =3D 188.044000 MHz
> [    0.000000] time_init: processor frequency   =3D 1504.352000 MHz
> [    0.000135] Console: colour dummy device 80x25
>=20
> Effectivly including the uptime in printk()s.

Is this what other archs do?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-X5rH9bbMbDjVaukoX9EM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGiyHEdSjSd0sB4dIRAuQaAJ4luHA99iCRLl7+N70ZTVeErQCufwCguD+N
zaj8nQ/lz6yi7u0XkUJ5vOg=
=xf25
-----END PGP SIGNATURE-----

--=-X5rH9bbMbDjVaukoX9EM--
