Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Remove remaining iSeries debugger cruft
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060502040557.DE09667C13@ozlabs.org>
References: <20060502040557.DE09667C13@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RhCCWd2rY8pA8TvB+yOu"
Date: Tue, 02 May 2006 14:52:39 +1000
Message-Id: <1146545559.27495.32.camel@localhost.localdomain>
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


--=-RhCCWd2rY8pA8TvB+yOu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-02 at 14:05 +1000, Michael Ellerman wrote:
> This isn't needed anymore, as no one is using this debugger. Doesn't have
> any effect on early debug output etc.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---

This is bogus, it moves the embedded_sysmap variables, new patch coming.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-RhCCWd2rY8pA8TvB+yOu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEVuWXdSjSd0sB4dIRAjqzAJsFZTVPntUi5Fb9r1qSoA2F0jgdbwCfTHta
y/F3hECAH4YHis4a1z1d9OM=
=BEeh
-----END PGP SIGNATURE-----

--=-RhCCWd2rY8pA8TvB+yOu--
