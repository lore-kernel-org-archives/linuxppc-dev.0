Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id DD571B7BD2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 22:22:59 +1000 (EST)
Received: from antares (xdsl-78-34-98-203.netcologne.de [78.34.98.203])
	by smtp5.netcologne.de (Postfix) with ESMTP id 1F00040DB87
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 14:22:57 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id DEC1ABA03C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 14:22:56 +0200 (CEST)
Date: Sun, 27 Sep 2009 14:22:40 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: lite5200b kernel not booting
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9e4733910909250515p60e0b0e0v8c10063326fe882c@mail.gmail.com>
	(from jonsmirl@gmail.com on Fri Sep 25 14:15:57 2009)
Message-Id: <1254054175.3445.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-eJWB6zpYRWf7zM1vDSS2"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-eJWB6zpYRWf7zM1vDSS2
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.09.09 14:15 schrieb(en) Jon Smirl:
> No one has tried the Macraigor USB wiggler on the mpc5200 and =20
> reported back if it works.

I'm working on a self-designed, roughly Lite5200B based board, and =20
first thought about buying this device.  However, I tried to contact =20
their support several times (as to get a confirmation that it will work =20
with our flash and board-specific design), but never got a reply.  So =20
we ended up with the Abatron BDI3000, which is rather expensive, but =20
works really flawlessly, and Abatron's (and their German distributor's) =20
support is just *excellent* (fast and professional).

> uboot 1.2 is very old. That may be the cause of your problems. For =20
> example old u-boots don't initialize the PCI hardware correctly on =20
> systems that don't have PCI implemented.

U-Boot 2009.03 together with ELDK 4.2 work flawlessly on both the =20
Lite5200B and on our design.

> In general the current powerpc kernel works fine on the mpc5200b. We =20
> are running it on four different CPU boards but I don't have a =20
> lite5200b.

I can only confirm that the stock (from kernel.org) kernels run =20
flawlessly on our boards (the latest I tried was 2.6.30.3, though, but =20
I don't expect any issues with 2.6.31.1).

Hope this helps,
Albrecht.

--=-eJWB6zpYRWf7zM1vDSS2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKv1kfn/9unNAn/9ERAgw7AJsE2tGQSxy0+Y09zZCOKcC0NQ3dMACdHbJD
jebp/A3ZgKvNq2wvMqQU2bw=
=TjHv
-----END PGP SIGNATURE-----

--=-eJWB6zpYRWf7zM1vDSS2--
