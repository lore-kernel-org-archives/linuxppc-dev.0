Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DE9E3DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 10:50:27 +1000 (EST)
Date: Thu, 25 Oct 2007 10:50:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] mpc52xx: add cdm (clock module) helper function for
	PSCs
Message-Id: <20071025105021.1107f717.sfr@canb.auug.org.au>
In-Reply-To: <20071024182426.21194.57761.stgit@trillian.cg.shawcable.net>
References: <20071024182308.21194.69416.stgit@trillian.cg.shawcable.net>
	<20071024182426.21194.57761.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__25_Oct_2007_10_50_21_+1000_7tmQ7C1AlZU9SsRi"
Cc: linuxppc-dev@ozlabs.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__25_Oct_2007_10_50_21_+1000_7tmQ7C1AlZU9SsRi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Oct 2007 12:24:26 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +static spinlock_t mpc52xx_cdm_lock =3D SPIN_LOCK_UNLOCKED;

static DEFINE_SPINLOCK(mpc52xx_cdm_lock);

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__25_Oct_2007_10_50_21_+1000_7tmQ7C1AlZU9SsRi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHH+hRTgG2atn1QN8RArjwAJ0aIy41Hdv6pMTe5NmuV1XYVyZ0vwCgkEnT
gr+htx4XyjDqHNwAqjHcOtE=
=1Q5D
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Oct_2007_10_50_21_+1000_7tmQ7C1AlZU9SsRi--
