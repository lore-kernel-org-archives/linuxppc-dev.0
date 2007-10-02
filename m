Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/7] Use dcr_host_t.base in ibm_emac_mal
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1191302025.6310.70.camel@pasglop>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<5022a72815fe6334b5255dbe1288036131c2c961.1190009070.git.michael@ellerman.id.au>
	<1191302025.6310.70.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nwFeGtL9KVfk7SyBk/bK"
Date: Tue, 02 Oct 2007 16:06:34 +1000
Message-Id: <1191305194.6593.10.camel@concordia>
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


--=-nwFeGtL9KVfk7SyBk/bK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-02 at 15:13 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> > This requires us to do a sort-of fake dcr_map(), so that base is set
> > properly. This will be fixed/removed when the device-tree-aware emac dr=
iver
> > is merged.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> (Have you actually tested btw ? :-)

Hmm, I wrote these in mid June, so to be honest I don't remember. I
don't think I boot tested it on anything, but I think I would have built
it.

I see now that the newemac driver is in Jeff's 24 tree, so it's probably
best to wait for Linus to merge that and then we can fix up it as well
in the one series.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-nwFeGtL9KVfk7SyBk/bK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAd/qdSjSd0sB4dIRAhDkAJ0Zl/iSDlMb+zT1vdc5EFvf6Dxh2ACgvcyv
t+1d9kSHSMf0ujqXRPw71xY=
=s/VA
-----END PGP SIGNATURE-----

--=-nwFeGtL9KVfk7SyBk/bK--
