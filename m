Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 8AEAFDE160
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:23:19 +1000 (EST)
Received: from antares (xdsl-78-34-249-56.netcologne.de [78.34.249.56])
	by smtp4.netcologne.de (Postfix) with ESMTP id 220CBDA594
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:23:17 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 0B491BA04B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 19:23:17 +0200 (CEST)
Date: Thu, 23 Apr 2009 19:23:09 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [OT] Lite5200B w/ nfs root hangs after some time
To: linuxppc-dev@ozlabs.org
References: <1240422181.5492.0@antares>
	<20090422181059.7510A83420E8@gemini.denx.de>
	<fa686aa40904221705r24f8093bn74d336ddc2b8edaf@mail.gmail.com>
In-Reply-To: <fa686aa40904221705r24f8093bn74d336ddc2b8edaf@mail.gmail.com>
	(from grant.likely@secretlab.ca on Thu Apr 23 02:05:40 2009)
Message-Id: <1240507396.5213.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-AePmGIf6ErjLFNKIeoWh"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-AePmGIf6ErjLFNKIeoWh
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.09 02:05 schrieb(en) Grant Likely:
>> http://patchwork.ozlabs.org/patch/24487/

That patch is already included in 2.6.29...

> No, that's not the problem in this case.  2.6.29 networking is broken =20
> for a lot of platforms, not just mpc5200.  Use 2.6.29.1 instead.

...and with 2.6.29.1, everything works flawlessly again!

Thanks a lot for your help,
Cheers, Albrecht.

--=-AePmGIf6ErjLFNKIeoWh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBJ8KQEn/9unNAn/9ERAiUBAJoC9LMxBntbdGmrJ1xsFjb6s9jxZwCgq/i8
bwr4XDmfembh4hMVnq/DNg4=
=2lF6
-----END PGP SIGNATURE-----

--=-AePmGIf6ErjLFNKIeoWh--
