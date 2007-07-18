Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 80D24DDE16
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 18:17:55 +1000 (EST)
Date: Wed, 18 Jul 2007 18:17:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 07/61] bootwrapper: Set timebase_period_ns from
	dt_fixup_cpu_clocks.
Message-Id: <20070718181746.96b8a750.sfr@canb.auug.org.au>
In-Reply-To: <20070718013304.GF15238@ld0162-tx32.am.freescale.net>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013304.GF15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__18_Jul_2007_18_17_46_+1000_M45cUhtBQye0Dz2p"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__18_Jul_2007_18_17_46_+1000_M45cUhtBQye0Dz2p
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jul 2007 20:33:04 -0500 Scott Wood <scottwood@freescale.com> wro=
te:
>
  void dt_fixup_cpu_clocks(u32 cpu, u32 tb, u32 bus)
>  {
> +	extern unsigned long timebase_period_ns;

Why isn't this declared in a header file somewhere?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__18_Jul_2007_18_17_46_+1000_M45cUhtBQye0Dz2p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGncyyTgG2atn1QN8RApzMAJ9V+unIdPsCkBeKlc2WeZxdbDvLvACeOjr4
wPv2XEzjyMt4w8Xk3MBJh+8=
=4nSL
-----END PGP SIGNATURE-----

--Signature=_Wed__18_Jul_2007_18_17_46_+1000_M45cUhtBQye0Dz2p--
