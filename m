Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] Raise the upper limit of NR_CPUS and move the
	pacas into the BSS.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <6bbf4d3637c9b72f9f0a4cf8a6f2c322c0784d7e.1209008469.git.tony@bakeyournoodle.com>
References: <b863aa7fba7b2b00cb72d327fdd7a04b6cb81106.1209008469.git.tony@bakeyournoodle.com>
	<6bbf4d3637c9b72f9f0a4cf8a6f2c322c0784d7e.1209008469.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ezM/n5O7VWEVQMtB0gtq"
Date: Thu, 24 Apr 2008 14:08:49 +1000
Message-Id: <1209010129.9245.21.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ezM/n5O7VWEVQMtB0gtq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-04-24 at 13:43 +1000, Tony Breeds wrote:
> This patch adds the required functionality to fill in all pacas at runtim=
e.
>=20
> With NR_CPUS=3D1024
> text    data     bss     dec     hex filename
>  137 1704032       0 1704169  1a00e9 arch/powerpc/kernel/paca.o :Before
>  121 1179744  524288 1704153  1a00d9 arch/powerpc/kernel/paca.o :After

Niiiiice.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ezM/n5O7VWEVQMtB0gtq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIEAfRdSjSd0sB4dIRApXmAJsHheFWcHDjM2ImNVPFkn2AtnJ9XgCcD+5l
2itMCYyYHijwTk18wDrwmy8=
=QFYk
-----END PGP SIGNATURE-----

--=-ezM/n5O7VWEVQMtB0gtq--
