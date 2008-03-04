Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 65381DDE3E
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 21:12:30 +1100 (EST)
Date: Tue, 4 Mar 2008 21:12:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 05/17] Add OF-tree support to RapidIO controller driver.
Message-Id: <20080304211223.873c190e.sfr@canb.auug.org.au>
In-Reply-To: <1204648202-5495-5-git-send-email-wei.zhang@freescale.com>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-2-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-3-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-4-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-5-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__4_Mar_2008_21_12_23_+1100_CxM+Y.N+ucXXoHxm"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Mar_2008_21_12_23_+1100_CxM+Y.N+ucXXoHxm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Mar 2008 00:29:50 +0800 Zhang Wei <wei.zhang@freescale.com> wrot=
e:
>
> +static struct of_device_id fsl_of_rio_rpn_ids[] =3D {

const, please.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__4_Mar_2008_21_12_23_+1100_CxM+Y.N+ucXXoHxm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzSCMTgG2atn1QN8RAmxZAJ0eTNyAKpymSaqFrxY3Qc0Bobo2bgCeJARt
AEFhXgvOPfYvI6ENapgj0YU=
=wVRw
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Mar_2008_21_12_23_+1100_CxM+Y.N+ucXXoHxm--
