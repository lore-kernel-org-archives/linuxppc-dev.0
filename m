Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [Patch 1/3] User OProfile support for the IBM
	CELL processor SPU	event profiling
From: Michael Ellerman <michael@ellerman.id.au>
To: Carl Love <cel@us.ibm.com>
In-Reply-To: <1228177110.6509.286.camel@carll-linux-desktop>
References: <1228177110.6509.286.camel@carll-linux-desktop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-681ddgYCbB7JIyeA0aNK"
Date: Tue, 02 Dec 2008 12:02:13 +1100
Message-Id: <1228179733.8004.45.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-681ddgYCbB7JIyeA0aNK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-12-01 at 16:18 -0800, Carl Love wrote:
> This patch adds the SPU event profiling support for the IBM Cell
> processor to the list of available events. The opcontrol script
> patches include a test to see if there is a new cell specific file
> in the kernel oprofile file system.  If the file exists, then the
> kernel supports SPU event profiling. =20
>=20
> Signed-off-by: Carl Love <carll@us.ibm.com>
>=20

> Index: oprofile-cvs/doc/oprofile.xml
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- oprofile-cvs.orig/doc/oprofile.xml
> +++ oprofile-cvs/doc/oprofile.xml
> @@ -123,6 +123,10 @@ For information on how to use OProfile's
>                         of 2.6.22 or more recent.  Additionally, full sup=
port of SPE profiling requires a BFD library
>                         from binutils code dated January 2007 or later.  =
To ensure the proper BFD support exists, run
>                         the <code>configure</code> utility with <code>--w=
ith-target=3Dcell-be</code>.
> +
> +		       Profiling the Cell Broadband Engine using SPU events requires a=
 kernel version of 2.6.TBD or
                                                                           =
                                    ^^^

Not sure if you missed that, or it's still TBD, but careful it doesn't
get merged like that.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-681ddgYCbB7JIyeA0aNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk0iRUACgkQdSjSd0sB4dJN/gCgiER9/Doa96NK7FRiUspIgUhW
jpgAn3iCWh+kTg5wUPas1J6h76yMJc7Z
=Nt6/
-----END PGP SIGNATURE-----

--=-681ddgYCbB7JIyeA0aNK--
