Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BED16DDE1F
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 15:09:23 +1100 (EST)
Date: Sun, 4 Nov 2007 15:09:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v2 05/12] [POWERPC] Export mpc52xx_map_node() routine
	symbol
Message-Id: <20071104150920.d0eac1ef.sfr@canb.auug.org.au>
In-Reply-To: <20071103235240.31906.93311.stgit@hekate.izotz.org>
References: <20071103235210.31906.83423.stgit@hekate.izotz.org>
	<20071103235240.31906.93311.stgit@hekate.izotz.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__4_Nov_2007_15_09_20_+1100_ZZDWKncLufPzv1N0"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__4_Nov_2007_15_09_20_+1100_ZZDWKncLufPzv1N0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marian,

On Sun, 04 Nov 2007 00:52:40 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> -static void __iomem *
> +void __iomem *
>  mpc52xx_map_node(struct device_node *ofn)
>  {
>  	const u32 *regaddr_p;
> @@ -48,6 +48,8 @@ mpc52xx_map_node(struct device_node *ofn)
>  	return ioremap((u32)regaddr64, (u32)size64);
>  }
> =20
> +EXPORT_SYMBOL(mpc52xx_map_node);
> +

We generally don't leave a blank line between a function an its
EXPORT_SYMBOL(). Also, any reason not to use EXPORT_SYMBOL_GPL?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__4_Nov_2007_15_09_20_+1100_ZZDWKncLufPzv1N0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHLUX2TgG2atn1QN8RAgkTAJ9lHRiOg4U/TOGjT6ZcRpspOA46pgCfa6KX
yn1Nbpe6csQIvWY0g71+sJA=
=h5RT
-----END PGP SIGNATURE-----

--Signature=_Sun__4_Nov_2007_15_09_20_+1100_ZZDWKncLufPzv1N0--
