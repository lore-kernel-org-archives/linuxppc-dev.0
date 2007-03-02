Return-Path: <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH] Allow spufs to build as a module with
	slices enabled
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070302021531.GA18693@lst.de>
References: <20070220074433.96AAEDDDEC@ozlabs.org>
	<20070301061134.0B4B2DDEC1@ozlabs.org> <20070302021531.GA18693@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6rQ/hOGy118TXXu8eKUF"
Date: Fri, 02 Mar 2007 13:10:31 +0900
Message-Id: <1172808631.518.48.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6rQ/hOGy118TXXu8eKUF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-03-02 at 03:15 +0100, Christoph Hellwig wrote:
> On Thu, Mar 01, 2007 at 03:11:31PM +0900, Michael Ellerman wrote:
> > The slice code is missing some exports to allow spufs to build as a
> > module. Add them.
>=20
> should be _GPL exports I think.

Yeah of course, I just hacked it up to get it building and didn't think
about it much. Benh said he'd add _GPL and respin the patch.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6rQ/hOGy118TXXu8eKUF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF56O3dSjSd0sB4dIRAjP2AKDMF6gWE6czyWgk9P+wBikmqFadYACfUbAN
SMz1ujImgcXNUNQ124rgqAE=
=Ra7o
-----END PGP SIGNATURE-----

--=-6rQ/hOGy118TXXu8eKUF--
