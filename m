Return-Path: <albrecht.dress@arcor.de>
Received: from smtp5.netcologne.de (smtp5.netcologne.de [194.8.194.25])
	by ozlabs.org (Postfix) with ESMTP id 79559B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 05:04:48 +1100 (EST)
Received: from antares (xdsl-89-0-161-224.netcologne.de [89.0.161.224])
	by smtp5.netcologne.de (Postfix) with ESMTP id 3682B40DC66
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 18:56:08 +0100 (CET)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 15A93BA03E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Dec 2009 18:56:08 +0100 (CET)
Date: Fri, 11 Dec 2009 18:55:56 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: Q: how to access the MPC5200B's timer gipo's?
To: linuxppc-dev@lists.ozlabs.org
References: <10228901.1260376093135.JavaMail.ngmail@webmail18.arcor-online.net>
	<fa686aa40912102202q38f787bei26bac38666702ee3@mail.gmail.com>
In-Reply-To: <fa686aa40912102202q38f787bei26bac38666702ee3@mail.gmail.com>
	(from grant.likely@secretlab.ca on Fri Dec 11 07:02:30 2009)
Message-Id: <1260554166.2313.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-nXZIqH4vA6Rmoefvy1u6"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-nXZIqH4vA6Rmoefvy1u6
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant:

Am 11.12.09 07:02 schrieb(en) Grant Likely:
> The existing API (of_get_gpio()) doesn't operate on gpio-controller
> nodes.  It operates on a node that uses the gpio (has a 'gpios'
> property as documented in
> Documentation/powerpc/dts-bindings/gpio/gpio.txt).

Thanks a lot for that pointer - I actually missed that documentation (so it=
 *was* a dumb question!.  Works as advertised when I add the gpio's to a (d=
ummy) node.

Thanks, Albrecht.

--=-nXZIqH4vA6Rmoefvy1u6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLIoe2n/9unNAn/9ERAr6XAKCowb43t+e4W0gz3KTGYOwWp/vDBwCfaXrp
V8SVtppZG8dvA2D3qOw8DVU=
=cloS
-----END PGP SIGNATURE-----

--=-nXZIqH4vA6Rmoefvy1u6--
