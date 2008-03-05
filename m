Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 903A7DDE30
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 13:51:57 +1100 (EST)
Date: Wed, 5 Mar 2008 13:51:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Zhang Wei" <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 11/17] Add memory mapping driver to RapidIO.
Message-Id: <20080305135148.21d6c25a.sfr@canb.auug.org.au>
In-Reply-To: <ABF87B0B6A38C0458E319AC973ED68AECE4522@zch01exm26.fsl.freescale.net>
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
	<20080304213735.c77d6203.sfr@canb.auug.org.au>
	<ABF87B0B6A38C0458E319AC973ED68AECE4522@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__5_Mar_2008_13_51_48_+1100_lP8xoRT_lZWZy.6q"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__5_Mar_2008_13_51_48_+1100_lP8xoRT_lZWZy.6q
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Weu,

On Wed, 5 Mar 2008 09:59:38 +0800 "Zhang Wei" <Wei.Zhang@freescale.com> wro=
te:
>
> Thanks! I'm considering to commit a updated patch or new code cleaning
> patch.
> How about your idea?

Preferably, fix up the patches.  If that is a pain, then a followup patch
that cleans up is ok as these do not affect the correctness of the code.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__5_Mar_2008_13_51_48_+1100_lP8xoRT_lZWZy.6q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzgrMTgG2atn1QN8RAtWOAJ9qPET8JOdSTx3VEWfVOHEmh386igCfV9Gl
arv6cBW1/qX78ISWMmgLmpc=
=dkVp
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Mar_2008_13_51_48_+1100_lP8xoRT_lZWZy.6q--
