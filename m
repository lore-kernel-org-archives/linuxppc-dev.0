Return-Path: <jason.mcmullan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.200])
	by ozlabs.org (Postfix) with ESMTP id 1F2DF67BDB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 00:55:19 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so176324nzp
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 01 Jul 2005 07:55:18 -0700 (PDT)
From: Jason McMullan <jason.mcmullan@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050701094438.GA11121@logos.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eeZonVDJvA3DB3pPGfGP"
Date: Fri, 01 Jul 2005 10:55:16 -0400
Message-Id: <1120229717.21507.9.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: Anton =?ISO-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-eeZonVDJvA3DB3pPGfGP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-01 at 06:44 -0300, Marcelo Tosatti wrote:
> Hi Anton,
>=20
>=20
> (moving to ppc-embedded since it might be of interesting for other=20
> 8xx users)
>=20

Apply this patch to glibc, and recompile:

rm -f glibc/sysdeps/powerpc/powerpc32/memset.S


The PPC32 dbcz semantics don't seem to work properly on 8xx
in all cases. Removing the '.S' file makes glibc fall back on
the .c implementation.

--=20
Jason McMullan <jason.mcmullan@gmail.com>
"Sure, send me the latest Knoppix DVD as an attachment..."

--=-eeZonVDJvA3DB3pPGfGP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCxVlU8/0vJ5szK6kRAq5SAJ97Y5HwASObw6cUvDs0LiErXdvwxACfd7zD
msVyFqi3fjMtw34lDYQDl5U=
=7tQH
-----END PGP SIGNATURE-----

--=-eeZonVDJvA3DB3pPGfGP--
