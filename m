Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Make RTAS console init generic
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060817032723.25A2767B6D@ozlabs.org>
References: <20060816194225.C9F1F67B32@ozlabs.org>
	<1155780267.6910.3.camel@localhost.localdomain>
	<20060817032723.25A2767B6D@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UikLIbbMRNF3yn02p13I"
Date: Thu, 17 Aug 2006 13:45:32 +1000
Message-Id: <1155786333.10665.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-UikLIbbMRNF3yn02p13I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-16 at 22:27 -0500, Michael Neuling wrote:
> > Seems to work fine on Cell.
>=20
> Kewl
>=20
> > > Updated Kconfig so we can enable it.=20
> >=20
> > I enable it via the early debugging menu (under kernel hacking), is tha=
t
> > not good enough?
>=20
> Doesn't that enable CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE not
> CONFIG_UDBG_RTAS_CONSOLE?

Yeah, but that then turns on CONFIG_UDBG_RTAS_CONSOLE also. I guess you
guys want to be able to turn on the later without the former, so fair
enough. We turn it on always on the Cell via the PPC_IBM_CELL_BLADE
entry.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UikLIbbMRNF3yn02p13I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE4+ZcdSjSd0sB4dIRAvg+AJ91ZEM2SzsroQtQZWtfpGMNBhZKJwCcDH3Y
wc0p4z0T+Q3S48lT80ySiBY=
=rb5c
-----END PGP SIGNATURE-----

--=-UikLIbbMRNF3yn02p13I--
