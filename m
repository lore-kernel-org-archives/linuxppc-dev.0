Return-Path: <michael@ellerman.id.au>
Subject: Re: drivers/net/iseries_veth.c dubious sysfs usage
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20071205093054.GA23229@kroah.com>
References: <20071205093054.GA23229@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CRFWAJjNy6+pDpjK21d4"
Date: Wed, 05 Dec 2007 22:10:31 +1100
Message-Id: <1196853031.6759.7.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Kyle A. Lucke" <klucke@us.ibm.com>,
	paulus@samba.org, linux-kernel@vger.kernel.org,
	David Gibson <dwg@au1.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-CRFWAJjNy6+pDpjK21d4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-05 at 01:30 -0800, Greg KH wrote:
> In doing a massive kobject cleanup of the kernel tree, I ran across the
> iseries_veth.c driver.
>=20
> It looks like the driver is creating a number of subdirectories under
> the driver sysfs directory.  This is odd and probably wrong.  You want
> these virtual connections to show up in the main sysfs device tree, not
> under the driver directory.
>=20
> I'll be glad to totally guess and try to move it around in the sysfs
> tree, but odds are I'll get it all wrong as I can't really test this
> out :)
>=20
> Any hints on what this driver is trying to do in this sysfs directories?

I wrote the code, I think, but it's been a while - I'll have a look at
it tomorrow.

Why is it "odd and probably wrong" to create subdirectories under the
driver in sysfs?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CRFWAJjNy6+pDpjK21d4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHVocndSjSd0sB4dIRAjaYAJ9OZhuAhxI2vbdF1hIiRajoCY/rjgCfTS/s
vJPPnnU8o3gnnvUnEBpmyCU=
=3mbJ
-----END PGP SIGNATURE-----

--=-CRFWAJjNy6+pDpjK21d4--
