Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] kdump : Support kernels having 64k page size.
From: Michael Ellerman <michael@ellerman.id.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
In-Reply-To: <44FE15B0.3030909@in.ibm.com>
References: <44FE15B0.3030909@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eBWmxWC3m8tdHB2JNG/2"
Date: Wed, 06 Sep 2006 12:59:37 +1000
Message-Id: <1157511577.3661.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eBWmxWC3m8tdHB2JNG/2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-09-06 at 05:56 +0530, Sachin P. Sant wrote:
> The following  kernel patch [ along with a patch to kexec tools posted=20
> seperately ]
> is required to generate proper core files using kdump on ppc64.

Hi Sachin,

Can you provide some more explanation? It's not clear to me why this is
necessary.

thanks

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-eBWmxWC3m8tdHB2JNG/2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE/jmZdSjSd0sB4dIRAkwsAJ4qERUb7cGaMuBISZeYlP4eXVlkRwCcD570
iMCtqlmEci9OulzeX17bvYk=
=K7WK
-----END PGP SIGNATURE-----

--=-eBWmxWC3m8tdHB2JNG/2--
