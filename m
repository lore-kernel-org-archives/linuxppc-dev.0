Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 14:15:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080708041521.GA7328@yookeroo.seuss>
References: <20080612090433.GA4235@pengutronix.de>
	<20080613042304.GD29451@yookeroo.seuss>
	<20080620161033.GE17701@pengutronix.de>
	<20080623050624.GA23064@yookeroo.seuss>
	<20080627170547.GF3931@pengutronix.de>
	<20080707012843.GF6267@yookeroo.seuss>
	<20080707092347.GB4409@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
In-Reply-To: <20080707092347.GB4409@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2008 at 11:23:47AM +0200, Wolfram Sang wrote:
> On Mon, Jul 07, 2008 at 11:28:43AM +1000, David Gibson wrote:
>=20
> > > This function is surely needed in every case I considered so far. I am
> > > just sceptical if the boot-loader can determine a correct parentoffset
> > > all alone (which one of the two I2C busses is the correct one?). This=
 is
> >=20
> > Hrm.  "all alone".  It's not clear to me what else there could be that
> > would have more information than the bootloader.
>=20
> What I meant is that all the information a bootloader has may not be
> sufficent. To solve this, some additional infos could be added to the
> tree. In this case, it could be a few aliases.

My point is that the dts and the bootloader will typically be built by
the same person as part of the same process.  What is the rationale
for encoding this information into the tree fragments rather than the
code?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIcunZaILKxv3ab8YRAjnLAJsFH1KMnsucCY58MyQVBbSq+Jdu7wCfbfmM
S3fpz2rsH6Jvf+M0Y+XsCR0=
=ttdj
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
