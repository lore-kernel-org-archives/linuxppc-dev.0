Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH V2 3/3] powerpc: Disable VPHN polling during a suspend
	operation
From: Michael Ellerman <michael@ellerman.id.au>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
In-Reply-To: <20101109232514.17098.84090.sendpatchset@manic8ball.ltc.austin.ibm.com>
References: <20101109232436.17098.20055.sendpatchset@manic8ball.ltc.austin.ibm.com>
	<20101109232514.17098.84090.sendpatchset@manic8ball.ltc.austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-CtCqJvaw45U/efKAXx07"
Date: Wed, 10 Nov 2010 11:58:44 +1100
Message-ID: <1289350724.22787.12.camel@concordia>
Mime-Version: 1.0
Cc: markn@au1.ibm.com, pmac@au1.ibm.com, tbreeds@au1.ibm.com,
	lkessler@us.ibm.com, mjwolf@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-CtCqJvaw45U/efKAXx07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-11-09 at 16:25 -0700, Jesse Larrew wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>=20
> Tie the polling mechanism into the ibm,suspend-me rtas call to
> stop/restart polling before/after a suspend, hibernate, migrate,
> or checkpoint restart operation. This ensures that the system has a
> chance to disable the polling if the partition is migrated to a system
> that does not support VPHN (and vice versa).

I never got round to replying to you about my comments did I. This looks
good, in particular you're right about the error path in
__rtas_suspend_last_cpu(), I was getting muddled trying to read the code
while mentally adding the diff.

cheers

--=-CtCqJvaw45U/efKAXx07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzZ7kQACgkQdSjSd0sB4dIb6wCeKEsrQ1O4X7skH7lZAO6tUzSo
xLEAn0Q9EDGM7Umto4rnUMg7zvvir53h
=vQHi
-----END PGP SIGNATURE-----

--=-CtCqJvaw45U/efKAXx07--
