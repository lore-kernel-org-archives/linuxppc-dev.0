Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2E2B2DDEC8
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 13:36:37 +1100 (EST)
Date: Wed, 12 Dec 2007 13:36:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <randy.dunlap@ORACLE.COM>
Subject: Re: [PATCH] Introduce driver_create/remove_dir
Message-Id: <20071212133630.7bf1686f.sfr@canb.auug.org.au>
In-Reply-To: <20071211164039.013f4393.randy.dunlap@oracle.com>
References: <20071205093054.GA23229@kroah.com>
	<1196853031.6759.7.camel@concordia>
	<20071205214103.GA7074@kroah.com>
	<1196912898.14754.13.camel@concordia>
	<20071212105633.725496cb.sfr@canb.auug.org.au>
	<20071211164039.013f4393.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Dec_2007_13_36_30_+1100_+.M/mc4RyaeGdNF9"
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	"Kyle A. Lucke" <klucke@us.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Dec_2007_13_36_30_+1100_+.M/mc4RyaeGdNF9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Dec 2007 16:40:39 -0800 Randy Dunlap <randy.dunlap@ORACLE.COM> w=
rote:
>
> On Wed, 12 Dec 2007 10:56:33 +1100 Stephen Rothwell wrote:
>=20
> > +/**
> > + *	driver_remove_dir - remove a subdirectory for a driver.
> > + *	@drv:	driver.
> > + *	@attr:	driver attribute descriptor.
>=20
> Second arg below is @kobj.

Thanks, will fix (cut and paste error).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Dec_2007_13_36_30_+1100_+.M/mc4RyaeGdNF9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHX0kzTgG2atn1QN8RAvFWAKCRDJok+1WJSlgatPbCUoIMjhAWHQCbBPgU
RQ5YyESvYZbSvO1UPqPpoO0=
=fi6Y
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Dec_2007_13_36_30_+1100_+.M/mc4RyaeGdNF9--
