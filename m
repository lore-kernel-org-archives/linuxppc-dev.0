Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 279C0DDF1D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 21:37:43 +1100 (EST)
Date: Tue, 4 Mar 2008 21:37:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 11/17] Add memory mapping driver to RapidIO.
Message-Id: <20080304213735.c77d6203.sfr@canb.auug.org.au>
In-Reply-To: <1204648202-5495-11-git-send-email-wei.zhang@freescale.com>
References: <1204648202-5495-1-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-2-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-3-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-4-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-5-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-6-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-7-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-8-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-9-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-10-git-send-email-wei.zhang@freescale.com>
	<1204648202-5495-11-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__4_Mar_2008_21_37_35_+1100_FheMB3dhap5LZ3AQ"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__4_Mar_2008_21_37_35_+1100_FheMB3dhap5LZ3AQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Mar 2008 00:29:56 +0800 Zhang Wei <wei.zhang@freescale.com> wrot=
e:
>
> +	if (!(rmem->virt =3D dma_alloc_coherent(NULL, rmem->size,
> +				&rmem->iores.start, GFP_KERNEL))) {

Please separate assignments from tests.

> +	if ((ret =3D rio_space_claim(rmem))) {

Again.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__4_Mar_2008_21_37_35_+1100_FheMB3dhap5LZ3AQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFHzSZ2TgG2atn1QN8RAnAsAJiQG3hR7uCh1Y4iGrLhErKAVMDqAKCD0cmO
pKPSvpjjc2hhaiTqYlLTuA==
=ed+Y
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Mar_2008_21_37_35_+1100_FheMB3dhap5LZ3AQ--
