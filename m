Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 597E9DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:16:36 +1100 (EST)
Date: Sun, 23 Dec 2007 13:16:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-Id: <20071223131629.eab7c20b.sfr@canb.auug.org.au>
In-Reply-To: <20071221202309.GA4557@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__23_Dec_2007_13_16_29_+1100_DrlgBjHzkINr6XJx"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__23_Dec_2007_13_16_29_+1100_DrlgBjHzkINr6XJx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Dec 2007 23:23:09 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static struct of_device_id mpc836x_rdk_ids[] =3D {

Please make this __initdata.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__23_Dec_2007_13_16_29_+1100_DrlgBjHzkINr6XJx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHbcUCTgG2atn1QN8RAhzdAJ0cv26ZIszGMdJFOlKDFFHouS6SBwCdFifD
t0dBG8Wu8WCNagvG47ZfRAc=
=tmBe
-----END PGP SIGNATURE-----

--Signature=_Sun__23_Dec_2007_13_16_29_+1100_DrlgBjHzkINr6XJx--
