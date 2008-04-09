Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 9 Apr 2008 18:55:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: Re: [PATCH 5/6] [POWERPC] properly declare onstack completion in
	iseries veth
Message-Id: <20080409185530.6c36a2dd.sfr@canb.auug.org.au>
In-Reply-To: <20080409072230.C861EDDED0@ozlabs.org>
References: <20080409072230.C861EDDED0@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Apr_2008_18_55_30_+1000_Ykd_cwm3bxwP=HpH"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_Apr_2008_18_55_30_+1000_Ykd_cwm3bxwP=HpH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Apr 2008 17:21:34 +1000 Benjamin Herrenschmidt <benh@ozlabs.org>=
 wrote:
>
> The iSeries veth driver uses an on-stack struct completion that
> it initializes using the COMPLETION_INITIALIZER instead of
> COMPLETION_INITIALIZER_ONSTACK macro, causing problems with
> lockdep.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Apr_2008_18_55_30_+1000_Ykd_cwm3bxwP=HpH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH/ISITgG2atn1QN8RAvOpAJ92BdAq1zwfWGo01ycY7pbYvJku6gCdE4/R
360zSJbE5d2xjbYGjXDkOG4=
=smFh
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Apr_2008_18_55_30_+1000_Ykd_cwm3bxwP=HpH--
