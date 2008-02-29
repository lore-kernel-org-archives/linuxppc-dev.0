Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] Please pull 'for-2.6.25' branch of cell tree
From: Michael Ellerman <michael@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200802290612.56728.arnd@arndb.de>
References: <200802290612.56728.arnd@arndb.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-i9r8vhxlWgA/7bEIyMub"
Date: Fri, 29 Feb 2008 17:13:16 +1100
Message-Id: <1204265597.7729.27.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-i9r8vhxlWgA/7bEIyMub
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-02-29 at 06:12 +0100, Arnd Bergmann wrote:
> Hi Paul,
>=20
> Please pull from:
>=20
>  master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.25
>=20
> To pick up a few small fixes for the cell platform. Most of it is a follo=
w-up
> to the IOMMU rework that got merged in 2.6.25-rc1 and caused problems on
> machines with large amounts of memory.

Sorry, I have updated versions of the IOMMU patches to send. Arnd is
away for the weekend, so Paul if you just want to cherry pick the other
fixes that might work. I'll send the updated IOMMU patches momentarily.

Apologies for the churn.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-i9r8vhxlWgA/7bEIyMub
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHx6J8dSjSd0sB4dIRAqtEAJ4960xmTsK4Eb/Iev+n9XaybBDJ0gCgs7r6
khikl6h+/RGNvYdik35ucWo=
=DWX7
-----END PGP SIGNATURE-----

--=-i9r8vhxlWgA/7bEIyMub--
