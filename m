Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3CD7ADE051
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:24:50 +1000 (EST)
Date: Wed, 11 Jun 2008 02:24:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: Re: [PATCH 3/5] powerpc/ibm_iic: remove support for OCP
Message-Id: <20080611022442.80fc8092.sfr@canb.auug.org.au>
In-Reply-To: <20080610142947.974805307@arndb.de>
References: <20080610142702.354823071@arndb.de>
	<20080610142947.974805307@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__11_Jun_2008_02_24_42_+1000_lC8Vq/mD5Qf0QoZU"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, i2c@lm-sensors.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__11_Jun_2008_02_24_42_+1000_lC8Vq/mD5Qf0QoZU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, 10 Jun 2008 16:27:05 +0200 arnd@arndb.de wrote:
>
> OCP is dead, so all code referring to it can go away as well.
>=20
> Cc: i2c@lm-sensors.org
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There is already a patch in the i2c tree to do this one.  Commit id
c73327b0f4d96f76a9b57eecdc7594a98c04ab62 ("i2c-ibm_iic: Remove deprecated
OCP style part") in today's linux-next tree if you want to compare.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__11_Jun_2008_02_24_42_+1000_lC8Vq/mD5Qf0QoZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhOqsoACgkQTgG2atn1QN8SDgCggfjI2jM2aMvnPTF0C5zpi37N
AU0An3Gvkkrv2nEPmGDTAi8ApaVbQeSq
=9D2v
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Jun_2008_02_24_42_+1000_lC8Vq/mD5Qf0QoZU--
