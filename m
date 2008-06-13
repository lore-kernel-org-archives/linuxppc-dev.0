Return-Path: <dgibson@ozlabs.org>
Date: Fri, 13 Jun 2008 14:23:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080613042304.GD29451@yookeroo.seuss>
References: <20080612090433.GA4235@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <20080612090433.GA4235@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 11:04:33AM +0200, Wolfram Sang wrote:
> Hello,
>=20
> a project I am working on consists of different hardware modules, which
> can be combined in a lot of variations (not at runtime, though). As each
> module shall contain an I2C-eeprom, the idea is now to put a fragment of
> a FDT-blob into that EEPROM and let the bootloader combine these
> fragments. Such an approach was also sketched by David Gibson recently.
> (http://ozlabs.org/pipermail/linuxppc-dev/2008-February/051630.html)
>=20
> (As a sidenote, I am not quite sure and could not find anything about
> what the mentioned 'fdt_graft' should actually do, in my case something
> like a 'fdt_add_blob_subnode' function would be sufficent, I guess.)

fdt_add_blob_subnode() sounds like it would do the same thing as I
envisaged fdt_graft() doing.

> My question: Is there already an effort towards such an approach to
> which I could contribute, or do I have to start from scratch?

I don't know of anyone who's implemented this specifically, but if you
do get there first, please do it on top of libfdt.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIUfYoaILKxv3ab8YRAmCZAJ0dTOTLZdjOTDPaSnYmaUUiwuKoPwCeN7wE
KRi3cQ+O0OlwHIiE8O9g6UU=
=m53P
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
