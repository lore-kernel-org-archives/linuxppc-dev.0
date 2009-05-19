Return-Path: <albrecht.dress@arcor.de>
Received: from smtp2.netcologne.de (smtp2.netcologne.de [194.8.194.112])
	by ozlabs.org (Postfix) with ESMTP id 7E4BEDE002
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 04:00:47 +1000 (EST)
Received: from antares (cable-195-14-199-136.netcologne.de [195.14.199.136])
	by smtp2.netcologne.de (Postfix) with ESMTP id 9FB904B2A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 20:00:44 +0200 (MEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 86F3FBA042
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 20:00:44 +0200 (CEST)
Date: Tue, 19 May 2009 20:00:36 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Q: MTD RAM in OF Device Tree
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20090519122714.GH30753@pengutronix.de> (from
	w.sang@pengutronix.de on Tue May 19 14:27:14 2009)
Message-Id: <1242756044.3502.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-RX9+FxudCdKHnL1CnQm3"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-RX9+FxudCdKHnL1CnQm3
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram!

Am 19.05.09 14:27 schrieb(en) Wolfram Sang:
> I wrote such a driver (yet without partitioning support) and I am =20
> trying to get it mainline, just didn't get any comments so far:
>=20
> http://patchwork.ozlabs.org/patch/23557/
> http://patchwork.ozlabs.org/patch/23556/

Thanks a lot, this is *exactly* what I was looking for!  Actually, =20
partition support is not important as I want to use the whole chip - =20
512k isn't *that* much...

> I'd be happy if you could give it a try and donate some =20
> {Acked|Tested|Reviewed}-by tags. Maybe this will help for my next try =20
> to get it mainline.

Will do that once I get it running completely.  The first test =20
triggered some strange problems when I wrote to /dev/mtdn and read back =20
the data (which is supposed to give "raw" direct access, right?) - the =20
last dword in each 512 byte block is partly broken.  Probably something =20
in the localbus layout or timing...

Thanks again,
Albrecht.

--=-RX9+FxudCdKHnL1CnQm3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD4DBQBKEvPMn/9unNAn/9ERAgLWAJ9pVYhWvINEG7Q2n4c09mJdpF2qTACXUgZ6
c44gnTQDIa7Qlzg+B0WFYQ==
=wcKw
-----END PGP SIGNATURE-----

--=-RX9+FxudCdKHnL1CnQm3--
