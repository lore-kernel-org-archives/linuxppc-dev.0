Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4C7DDDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 11:12:13 +1100 (EST)
Date: Sat, 22 Dec 2007 11:12:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hugh Blemings <hugh@blemings.org>
Subject: Re: [PATCH 10/21] [POWERPC] Base support for 440GX Taishan eval board
Message-Id: <20071222111204.70e342c2.sfr@canb.auug.org.au>
In-Reply-To: <20071221043932.C2FA1DDEDD@ozlabs.org>
References: <20071221043932.C2FA1DDEDD@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__22_Dec_2007_11_12_04_+1100_KvG4rV=l7F3+jk=0"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__22_Dec_2007_11_12_04_+1100_KvG4rV=l7F3+jk=0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 15:39:28 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-merge/arch/powerpc/platforms/44x/taishan.c	2007-12-21 14:20:04.=
000000000 +1100
> +
> +static struct of_device_id taishan_of_bus[] =3D {

__initdata (preferably) or const, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__22_Dec_2007_11_12_04_+1100_KvG4rV=l7F3+jk=0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbFZcTgG2atn1QN8RAlsPAJ9kTdH7C14/xebQlh+WIkCgo07lJgCfZe4K
4naRIwVUD67SXE+FeO3Eigc=
=SjuQ
-----END PGP SIGNATURE-----

--Signature=_Sat__22_Dec_2007_11_12_04_+1100_KvG4rV=l7F3+jk=0--
