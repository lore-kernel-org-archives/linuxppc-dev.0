Return-Path: <michael@ellerman.id.au>
Subject: Re: SMP in 32-bit arch/powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1154507145.24203.0.camel@localhost.localdomain>
References: <1154507145.24203.0.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JeotpiqhWMJ87/wbgIx+"
Date: Wed, 02 Aug 2006 19:08:20 +1000
Message-Id: <1154509700.26242.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-JeotpiqhWMJ87/wbgIx+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-02 at 09:25 +0100, Adrian Cox wrote:
> Is anybody else having problems with 32-bit SMP support in arch/powerpc?
> I'm using 2.6.17 as my current base, because I've not yet merged the
> latest mpic changes.
>=20
> I'm currently bringing up a dual-7448 board, and when I build the kernel
> with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
> strange thing is, this still happens when I don't start the second CPU.
> Kernels built without CONFIG_SMP run flawlessly on the same hardware.

Seems to be working OK here:

fuego:~# uname -a
Linux fuego 2.6.17 #1 SMP Mon Jul 3 12:10:43 EST 2006 ppc GNU/Linux
fuego:~# cat /proc/cpuinfo
processor       : 0
cpu             : 604r
clock           : 332.000000MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 82.68

processor       : 1
cpu             : 604r
clock           : 332.000000MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 82.68

processor       : 2
cpu             : 604r
clock           : 332.000000MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 82.68

processor       : 3
cpu             : 604r
clock           : 332.000000MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 82.68

total bogomips  : 330.75
timebase        : 41500582
platform        : CHRP
machine         : CHRP IBM,7025-F50

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-JeotpiqhWMJ87/wbgIx+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE0GuEdSjSd0sB4dIRAoxrAKCJGjw0rWn9z8+9F2zyMwJKkSw+SwCeOlOm
Jz2BB5gM7dmgXDT7T79VF24=
=ZsO+
-----END PGP SIGNATURE-----

--=-JeotpiqhWMJ87/wbgIx+--
