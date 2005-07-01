Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 556D667BEB
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jul 2005 10:27:49 +1000 (EST)
Date: Fri, 1 Jul 2005 10:27:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: domen@coderock.org
Message-Id: <20050701102741.50361e86.sfr@canb.auug.org.au>
In-Reply-To: <20050630220349.966609000@>
References: <20050630220349.966609000@>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__1_Jul_2005_10_27_41_+1000_BqIk/RCd4Uylr1MA"
Cc: clucas@rotomalug.org, linuxppc-dev@ozlabs.org
Subject: Re: [patch 1/1] Audit return code : drivers/macintosh/apm_emu.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__1_Jul_2005_10_27_41_+1000_BqIk/RCd4Uylr1MA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Jul 2005 00:03:50 +0200 domen@coderock.org wrote:
>
> From: Christophe Lucas <clucas@rotomalug.org>
>=20
>=20
> Audit return codes (and handle failure correctly) for misc_register.

This patch was rejected against arch/i386/kernel/apm.c since the driver
can still do useful things even if the misc_register fails.  (I don't know
if this is true for the ppc emulation, just a note).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__1_Jul_2005_10_27_41_+1000_BqIk/RCd4Uylr1MA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCxI39FdBgD/zoJvwRAqp7AJ9gQYkkDWaTXKZdTrzhYs1g9zIzMwCgj0aY
+k1L2jO+XMsxzGS+JlNrBPQ=
=UCIK
-----END PGP SIGNATURE-----

--Signature=_Fri__1_Jul_2005_10_27_41_+1000_BqIk/RCd4Uylr1MA--
