Return-Path: <michael@ellerman.id.au>
Subject: Re: kernel expection generated with 2.6.21-mm1 kernel boot up
From: Michael Ellerman <michael@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
In-Reply-To: <463F06E2.5060308@linux.vnet.ibm.com>
References: <463F06E2.5060308@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Vqbs2dK09Ws70+xxYC2B"
Date: Mon, 07 May 2007 21:55:12 +1000
Message-Id: <1178538912.24522.12.camel@concordia.ozlabs.ibm.com>
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


--=-Vqbs2dK09Ws70+xxYC2B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-05-07 at 16:30 +0530, Kamalesh Babulal wrote:
> Hi,
>=20
> I tried compiling and booting up with 2.6.21-mm1 kernel
> on the following machine
>=20
> Architecture      :    PPC64
> CPU Type           :    POWER5 (gr)
> Machine Type    :    CHRP IBM,9117-570
> Base OS              :    Fedora Core 5
>=20

> [boot]0012 Setup Arch
>=20
> Node 0 active with no memory

This looks bad.

Can you attach a tarball of /proc/device-tree from the system (booted
with a different kernel obviously).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Vqbs2dK09Ws70+xxYC2B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGPxOgdSjSd0sB4dIRAv2tAKCVQkmLEw0l8D4v9Gv6qUvp/dQlPQCffP6w
xYAJlPHwJaYhMBhA+UWu4pw=
=9fey
-----END PGP SIGNATURE-----

--=-Vqbs2dK09Ws70+xxYC2B--
