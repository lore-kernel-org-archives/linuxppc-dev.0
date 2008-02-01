Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] pasemi: Fix thinko in dma_direct_ops setup
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080131235002.GA16753@lixom.net>
References: <18337.8955.539106.868486@cargo.ozlabs.ibm.com>
	<20080131064130.GA32344@lixom.net> <20080131235002.GA16753@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Ypa7VLdqYvEQZElEwIIJ"
Date: Fri, 01 Feb 2008 18:56:53 +1100
Message-Id: <1201852613.28809.2.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Ypa7VLdqYvEQZElEwIIJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-01-31 at 17:50 -0600, Olof Johansson wrote:
> [POWERPC] pasemi: Fix thinko in dma_direct_ops setup
>=20
> The first patch will just fall through and still set dma_data to a bad
> value, make it return directly instead.
>=20
> Signed-off-by: Olof Johansson <olof@lixom.net>

OK I get it now, sorry for the breakage.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Ypa7VLdqYvEQZElEwIIJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHotDFdSjSd0sB4dIRAoSyAJ4qMzbC3WtXkC9wRS7aBnvB1VrZyQCgpar7
I2/DeVZw7WFPgPQSIXDBNqQ=
=gt7h
-----END PGP SIGNATURE-----

--=-Ypa7VLdqYvEQZElEwIIJ--
