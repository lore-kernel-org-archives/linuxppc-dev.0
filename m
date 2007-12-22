Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 40F58DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 09:50:44 +1100 (EST)
Date: Sun, 23 Dec 2007 09:50:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] mpc85xx_ads: add in missing of_node_put()
Message-Id: <20071223095038.ce1ad7a5.sfr@canb.auug.org.au>
In-Reply-To: <20071221154009.GB20661@windriver.com>
References: <20071221154009.GB20661@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_09_50_38_+1100_l6LJMJtBw2p1xRZn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_09_50_38_+1100_l6LJMJtBw2p1xRZn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 10:40:09 -0500 Paul Gortmaker <paul.gortmaker@windriver=
.com> wrote:
>
> cpm2_pic_init() does its own of_node_get() so we should do an of_node_put=
()
> before calling it.

The of_node_put() should really go after the call to cpm2_pic_init(), that
way you retain a raised ref count at all times.  Sorry fo not being
entirely clear before.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_09_50_38_+1100_l6LJMJtBw2p1xRZn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbZTCTgG2atn1QN8RAqxyAKCC2gYzrTBAJnRHfJaDKGaouBMPGwCePABT
OSAQlNy6tH6xq4RM8CkTNuA=
=BvPj
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_09_50_38_+1100_l6LJMJtBw2p1xRZn--
