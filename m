Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ozlabs.org (Postfix) with ESMTP id ABE59B6F5F
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Apr 2011 14:40:41 +1000 (EST)
Subject: Re: [PATCH] powerpc: Standardise on MMU_NO_CONTEXT
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <b7bdf4b6e066671119a897d4d3dda800a096e0b5.1302503867.git.michael@ellerman.id.au>
References: <b7bdf4b6e066671119a897d4d3dda800a096e0b5.1302503867.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-y2hQ39RbpVK7R0bT/Ryb"
Date: Wed, 13 Apr 2011 14:40:41 +1000
Message-ID: <1302669641.5705.178.camel@concordia>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-y2hQ39RbpVK7R0bT/Ryb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-04-11 at 16:35 +1000, Michael Ellerman wrote:
> Use MMU_NO_CONTEXT as the initialiser for mm_context.id on book3e
> and hash64.

This breaks 40x, new patch coming.

cheers


--=-y2hQ39RbpVK7R0bT/Ryb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2lKUYACgkQdSjSd0sB4dLjQQCgwAlCKJRWDhAndo8QWgaNUP12
ib4Ani6xmSPMXmQ0Q1xZPZfZ+y73FCrq
=e6Vp
-----END PGP SIGNATURE-----

--=-y2hQ39RbpVK7R0bT/Ryb--
