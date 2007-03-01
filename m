Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 0/5] Support 64K pages mapping of SPE local stores on
	4K kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1171957452.861958.803775545202.qpush@grosgo>
References: <1171957452.861958.803775545202.qpush@grosgo>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/v5MyO4YspS5Cc3/miSE"
Date: Thu, 01 Mar 2007 16:29:27 +0900
Message-Id: <1172734167.518.6.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
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


--=-/v5MyO4YspS5Cc3/miSE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-20 at 18:44 +1100, Benjamin Herrenschmidt wrote:
> This serie of patches supports userland mappings of SPE local stores
> using 64K hardware pages rather than 4K on a kernel using 4K pages to
> improve performances.
>=20
> The current version of this serie relies on a hack to the generic code
> which is probably not acceptable upsteam. I have plans to do a proper
> fix but haven't had time to do it yet.
>=20
> The first patch of the serie is fairly independant of the rest and
> should be applied to 2.6.21 as I beleive it fixes a bug with handling
> of huge pages from SPEs.

Unfortunately this seems to break a test case I have which dmas between
two SPEs.

The process just seems to hang, the machine is still pingable. gdb hangs
attaching to the spu process, but killing the spu process from another
console seems to return the system to normal.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/v5MyO4YspS5Cc3/miSE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF5oDXdSjSd0sB4dIRAkKKAJ454gQ97w4zu/vFqvZbFKfl1gusgwCgu+c3
orTzY8V/Soqvg16DMBtUYOY=
=7bkD
-----END PGP SIGNATURE-----

--=-/v5MyO4YspS5Cc3/miSE--
