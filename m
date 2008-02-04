Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A4E85DDEC8
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:29:49 +1100 (EST)
Date: Tue, 5 Feb 2008 00:29:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/9] powerpc: fold the mpc8313 platform into the mpc831x
	platform
Message-Id: <20080205002943.f188d2cc.sfr@canb.auug.org.au>
In-Reply-To: <20080124204551.10cea5fd.kim.phillips@freescale.com>
References: <20080124204551.10cea5fd.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_00_29_43_+1100_+BGcYkPOEaW/_934"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_00_29_43_+1100_+BGcYkPOEaW/_934
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kim,

I know this is late, but just a trivial comment.

On Thu, 24 Jan 2008 20:45:51 -0600 Kim Phillips <kim.phillips@freescale.com=
> wrote:
>
> --- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
> +++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
> @@ -1,7 +1,7 @@
>  /*
> - * arch/powerpc/platforms/83xx/mpc8313_rdb.c
> + * arch/powerpc/platforms/83xx/mpc831x_rdb.c

Just remove the file name from the comment.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_00_29_43_+1100_+BGcYkPOEaW/_934
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpxNMTgG2atn1QN8RAv5/AJ4pywQ9CxQIuZk7kzLdNxAxUV2MAACfR1eR
vEvJo82BztBAi/5XpXbVLGI=
=uzGq
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_00_29_43_+1100_+BGcYkPOEaW/_934--
