Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
From: Michael Ellerman <michael@ellerman.id.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <47B90F55.2080606@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+cFJ0gv8MlDE2hxtgo0F"
Date: Fri, 22 Feb 2008 11:53:04 +1100
Message-Id: <1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Linas Vepstas <linasvepstas@gmail.com>,
	paulus <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+cFJ0gv8MlDE2hxtgo0F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2008-02-17 at 22:53 -0600, Manish Ahuja wrote:
> The following series of patches implement a basic framework
> for hypervisor-assisted dump. The very first patch provides=20
> documentation explaining what this is  :-) . Yes, its supposed
> to be an improvement over kdump.
>=20
> A list of open issues / todo list is included in the documentation.
> It also appears that the not-yet-released firmware versions this was test=
ed=20
> on are still, ahem, incomplete; this work is also pending.
>=20
> I have included most of the changes requested. Although, I did find
> one or two, fixed in a later patch file rather than the first location
> they appeared at.

This series still doesn't build on !CONFIG_RTAS configs:
http://kisskb.ellerman.id.au/kisskb/head/629/

This solution is to move early_init_dt_scan_phyp_dump() into
arch/powerpc/platforms/pseries/phyp_dump.c and provide a dummy
implementation in asm-powerpc/phyp_dump.c for the !CONFIG_PHYP_DUMP
case.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+cFJ0gv8MlDE2hxtgo0F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHvhzvdSjSd0sB4dIRAsjDAJ0dI78wKsy1kiWy85Z3ZC6csgpdpQCfWKBC
W6gr1dS6OAkiRqyFelsbVzQ=
=ClnW
-----END PGP SIGNATURE-----

--=-+cFJ0gv8MlDE2hxtgo0F--
