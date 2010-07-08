Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 6669CB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 06:09:55 +1000 (EST)
Date: Thu, 08 Jul 2010 22:09:51 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <1278614421.1801.0@antares>
	<DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
In-Reply-To: <DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
	(from segher@kernel.crashing.org on Thu Jul  8 21:30:33 2010)
Message-Id: <1278619791.1801.4@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-Myj4TfWaMWBaN6i4k3Wh"
Cc: David Woodhouse <dwmw2@infradead.org>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-Myj4TfWaMWBaN6i4k3Wh
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.07.10 21:30 schrieb(en) Segher Boessenkool:
>> Actually, this is something which might need closer attention - and mayb=
e some support in the device tree indicating which read or write width a de=
vice can accept?
>=20
> There already is "device-width"; the drivers never should use any other a=
ccess width unless they *know* that will work.

Hmm, unfortunately, it's usage is not clearly documented in mtd-physmap.txt=
, so I never thought of this parameter.  And IMHO the problem goes further =
- basically *any* chip which is attached to the LPB can be affected by this=
 problem, so it might be better to have a more general approach like a "chi=
p select property".

Cheers, Albrecht.

--=-Myj4TfWaMWBaN6i4k3Wh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBMNjCPn/9unNAn/9ERAiSAAJ9s49M0U3KsDqSySytw+xbEWTKyXACgsO+I
l3A+LPkWZSFdHRMqK0tMdz8=
=vX5Y
-----END PGP SIGNATURE-----

--=-Myj4TfWaMWBaN6i4k3Wh--
