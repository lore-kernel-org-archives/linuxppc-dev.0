Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E7A78DDEAB
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 13:51:25 +1100 (EST)
Date: Sat, 1 Mar 2008 13:51:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
Message-Id: <20080301135123.262bfdb0.sfr@canb.auug.org.au>
In-Reply-To: <1204307236.10146.1.camel@dyn9047017100.beaverton.ibm.com>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
	<1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307236.10146.1.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__1_Mar_2008_13_51_23_+1100_nk16wSDzj2uP_hbA"
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__1_Mar_2008_13_51_23_+1100_nk16wSDzj2uP_hbA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Feb 2008 09:47:16 -0800 Badari Pulavarty <pbadari@us.ibm.com> wr=
ote:
>
> Here is the latest for review. (just to make sure I didn't miss
> anything).

Sorry I didn't review the previous ones ... just a small thing.

> +	type =3D of_get_property(np, "device_type", NULL);

To use the of_ accessors, you need to include linux/of.h (currently
asm/prom.h include linux/of.h, but that may not always be true).  In
fact, I think you don't even need asm/prom.h.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__1_Mar_2008_13_51_23_+1100_nk16wSDzj2uP_hbA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHyMSwTgG2atn1QN8RAoucAJ4nv1AqAVxw9DurhB0eNWs4BCMXeACfa29l
c37eawY7yXNtg0MyKc06sUg=
=IF3Z
-----END PGP SIGNATURE-----

--Signature=_Sat__1_Mar_2008_13_51_23_+1100_nk16wSDzj2uP_hbA--
