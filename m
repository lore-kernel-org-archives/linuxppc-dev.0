Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 15/15] Add DEFINE_SPUFS_ATTRIBUTE()
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <f5fe712aef37d925902f3f6183f024b916cc89db.1189583010.git.michael@ellerman.id.au>
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<f5fe712aef37d925902f3f6183f024b916cc89db.1189583010.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IjPtDUXEgszoLTPl93oB"
Date: Wed, 12 Sep 2007 17:49:13 +1000
Message-Id: <1189583353.17835.22.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IjPtDUXEgszoLTPl93oB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-09-12 at 17:43 +1000, Michael Ellerman wrote:
> This patch adds DEFINE_SPUFS_ATTRIBUTE(), a wraper around
> DEFINE_SIMPLE_ATTRIBUTE which does the specified locking for the get
> routine for us.
>=20
> Unfortunately we need two get routines (a locked and unlocked version) to
> support the coredump code. This patch hides one of those (the locked vers=
ion)
> inside the macro foo.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/cell/spufs/file.c |  216 +++++++++++-------------=
------
>  1 files changed, 76 insertions(+), 140 deletions(-)


jk said:
> "Good god man!"

Yeah, I'm a bit lukewarm on this one. But the diffstat is nice, 50% code
reduction ain't bad :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-IjPtDUXEgszoLTPl93oB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG55n5dSjSd0sB4dIRAi9cAJ9bigA9vyHO4Kvx8pjL08siTbt7rgCfX464
B7Crsxl1N1UdibUEPQJNCY4=
=HPfv
-----END PGP SIGNATURE-----

--=-IjPtDUXEgszoLTPl93oB--
