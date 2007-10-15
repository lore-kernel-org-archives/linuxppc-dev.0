Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] Update ibm_newemac to use dcr_host_t.base
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1192481682.11795.23.camel@pasglop>
References: <33ee227bae85a8d7ccde69a717cff47000888354.1192440801.git.michael@ellerman.id.au>
	<4713B2A1.4000503@pobox.com>  <1192481682.11795.23.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A7Yqq5Mqt/48ElqgHa4c"
Date: Tue, 16 Oct 2007 09:22:59 +1000
Message-Id: <1192490579.6371.2.camel@concordia>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
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


--=-A7Yqq5Mqt/48ElqgHa4c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-16 at 06:54 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2007-10-15 at 14:34 -0400, Jeff Garzik wrote:
> > Michael Ellerman wrote:
> > > Now that dcr_host_t contains the base address, we can use that in the
> > > ibm_newemac code, rather than storing it separately.
> > >=20
> > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > > ---
> > >  drivers/net/ibm_newemac/mal.c |    9 +++++----
> > >  drivers/net/ibm_newemac/mal.h |    5 ++---
> > >  2 files changed, 7 insertions(+), 7 deletions(-)
> >=20
> > applied 1-5
>=20
> Those patches have been around for some time now, they didn't make
> paulus initial merge for reasons I'm not sure about but I think they
> should go into 2.6.24. Now the question is via Jeff or via Paulus ? :-)

The first three went in already, these are the following cleanups. I
wanted to wait for the newemac driver to go into Linus' tree via Jeff. I
have no opinion on who's tree they should go through from here.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-A7Yqq5Mqt/48ElqgHa4c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHE/ZTdSjSd0sB4dIRAr7XAJoC7nL/Nm1bpInATRW+QOk/RfoWFgCfTg9a
x51lspZhU4r/z0BjzaDqs1U=
=g8XX
-----END PGP SIGNATURE-----

--=-A7Yqq5Mqt/48ElqgHa4c--
