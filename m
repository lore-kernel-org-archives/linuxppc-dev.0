Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch] ipmi: check, if default ports are accessible on PPC
From: Michael Ellerman <michael@ellerman.id.au>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20070226160917.2c801ec7@localhost>
References: <1172223703.4695.59.camel@concordia.ozlabs.ibm.com>
	<20070223135859.62e19ca8@localhost>
	<1172295412.16060.8.camel@concordia.ozlabs.ibm.com>
	<20070226160917.2c801ec7@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0E7bOQnm411CVFZ+jk6/"
Date: Tue, 27 Feb 2007 11:27:10 +0900
Message-Id: <1172543230.15967.47.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0E7bOQnm411CVFZ+jk6/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-26 at 16:09 +0100, Christian Krafft wrote:
> Subject: ipmi: check, if default ports are accessible on PPC
>=20
> From: Christian Krafft <krafft@de.ibm.com>
>=20
> ipmi_si_intf tries to access default ports, if no device could
> be found elsewhere. On PPC we have a function to check,
> if these legacy IO ports are accessible. This patch adds
> a check for these ports on PPC.
> This patch fixes a breakage of IPMI module
> on PPC machines without a BMC.
>=20
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Yep that fixes the problem on my machine.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0E7bOQnm411CVFZ+jk6/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF45b9dSjSd0sB4dIRAr2/AJ0VeujYBwHyV+5bePsqTQkR7O0EEACgkPhb
SSK4x5MPry/90lirMibgwP0=
=iYxV
-----END PGP SIGNATURE-----

--=-0E7bOQnm411CVFZ+jk6/--
