Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 7ABFDDDF0B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 17:45:29 +1100 (EST)
Date: Wed, 12 Mar 2008 17:44:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix viodasd driver with scatterlist debug
Message-Id: <20080312174418.e7206a9b.sfr@canb.auug.org.au>
In-Reply-To: <20080312062407.492AEDDED5@ozlabs.org>
References: <20080312062407.492AEDDED5@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__12_Mar_2008_17_44_18_+1100_zBSQzc9pC_jOPAIW"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__12_Mar_2008_17_44_18_+1100_zBSQzc9pC_jOPAIW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Wed, 12 Mar 2008 17:23:56 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> The iSeries viodasd drivers does some very strange things with
> scatterlists, one of these causing a BUG_ON to trigger when
> scatterlist debugging is enabled due to initializing the
> scatterlist with memset instead of sg_init_table().
>=20
> This fixes it by using sg_init_table(). The rest of the stuff
> it does to that poor list is still pretty awful but it will work.

Presumably this is also needed in 2.6.24.xx

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__12_Mar_2008_17_44_18_+1100_zBSQzc9pC_jOPAIW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH13vHTgG2atn1QN8RAqCtAKCS0Wt04+GwTykMEjXrYKQaWN4k5QCffyNN
xd/TTkEFbfupPJd4Z3AJBkw=
=yMxT
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Mar_2008_17_44_18_+1100_zBSQzc9pC_jOPAIW--
