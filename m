Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] hide kernel only code in asm-powerpc/elf.h
From: Michael Ellerman <michael@ellerman.id.au>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20080125180841.GA30091@aepfle.de>
References: <20080125180841.GA30091@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bLXs4ijktZ868W8+IAaI"
Date: Wed, 30 Jan 2008 12:42:05 +1100
Message-Id: <1201657325.15799.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-bLXs4ijktZ868W8+IAaI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-01-25 at 19:08 +0100, Olaf Hering wrote:
> stuff inside CONFIG_* should not be exported via make headers-install
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>=20
> ---
>  include/asm-powerpc/elf.h |    2 ++
>  1 file changed, 2 insertions(+)

Thanks Olaf, I noticed that once but forgot to fix it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-bLXs4ijktZ868W8+IAaI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHn9XtdSjSd0sB4dIRAmNZAKCDFjNIy+AMQmPDf28ymdkkpFZkcACdEk36
Iml1uBsqAVQdOCrNf93vC5M=
=vrxm
-----END PGP SIGNATURE-----

--=-bLXs4ijktZ868W8+IAaI--
