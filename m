Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/7] Add dcr_map_reg() helper
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1191302382.6310.80.camel@pasglop>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<60649f36e785af905b8cb1fd12847d7630e7371a.1190009070.git.michael@ellerman.id.au>
	<1191302382.6310.80.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UZs7B9FeGqlgpGuLMEY2"
Date: Tue, 02 Oct 2007 15:51:40 +1000
Message-Id: <1191304300.6593.2.camel@concordia>
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


--=-UZs7B9FeGqlgpGuLMEY2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-02 at 15:19 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> > Add a helper routine to map dcr's based on the "dcr-reg" property of
> > a device node.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Wouldn't it be more consistent to call it of_map_dcr ? Or maybe find an
> even better name, but dcr_map_reg really sucks :-)

That would give us dcr_map(), dcr_unmap() and of_map_dcr() - which
doesn't strike me as more consistent.

I don't particularly like dcr_map_reg(), but I think it's at least
obvious that it's a variant of dcr_map() and that it has something to do
with a "reg" .. maybe even a "dcr-reg" :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-UZs7B9FeGqlgpGuLMEY2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAdxsdSjSd0sB4dIRAkenAKDJ9v8r+vWplavX3oSbON+WQw3eCQCgk3fF
oWirIVNHWwJvyLZl0Vd6qt8=
=f/Et
-----END PGP SIGNATURE-----

--=-UZs7B9FeGqlgpGuLMEY2--
