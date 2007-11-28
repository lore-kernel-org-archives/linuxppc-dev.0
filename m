Return-Path: <michael@ellerman.id.au>
Subject: Re: Problems booting a 64k page kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: aglitke <agl@us.ibm.com>
In-Reply-To: <1196290249.27582.122.camel@localhost.localdomain>
References: <1196290249.27582.122.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4SggCRr72wd5ugQxPUnD"
Date: Thu, 29 Nov 2007 10:39:02 +1100
Message-Id: <1196293142.7875.1.camel@concordia>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-4SggCRr72wd5ugQxPUnD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-11-28 at 16:50 -0600, aglitke wrote:
> Hello all.  I am new to building 64k page kernels and can't seem to get
> one to boot correctly.  Everything looks okay until init gets a signal
> 11 while booting.  Attached is my boot log and the kernel config I used.
> To generate this config I merely enabled the 64k page option in make
> menuconfig to alter a previously working config.
>=20
> Any help you can provide would be greatly appreciated.

I've seen that happen with an init linked with uClibc, its dynamic
loader was doing mmap with MAP_FIXED on non-64K aligned addresses.
What user space are you using?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-4SggCRr72wd5ugQxPUnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHTfwWdSjSd0sB4dIRAp94AKCuQ3Ltd63/CkFtiWLUDy9mH866tQCfVrx1
8mOjW8wPfcF5+vcs0nZ0Qso=
=0bNG
-----END PGP SIGNATURE-----

--=-4SggCRr72wd5ugQxPUnD--
