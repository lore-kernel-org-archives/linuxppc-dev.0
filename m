Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3648167AC5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 19:43:27 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148544004.13249.270.camel@localhost.localdomain>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
	<1148169389.13249.44.camel@localhost.localdomain>
	<1148280172.6228.79.camel@johannes.berg>
	<1148422544.13249.96.camel@localhost.localdomain>
	<1148463777.11734.19.camel@johannes>
	<1148544004.13249.270.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9zCgB0rekHq8jzA1eaNJ"
Date: Thu, 25 May 2006 11:42:47 +0200
Message-Id: <1148550168.11759.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9zCgB0rekHq8jzA1eaNJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 18:00 +1000, Benjamin Herrenschmidt wrote:

> So it's bcm's fault ? Did you do a bit of analysis ? that would be
> useful...

I kinda assumed the list was lagging again and my brother had already
posted the solution. Yes, bcm does some measuring stuff that keeps
interrupts disabled for lots of milliseconds (25 or something). It's
being fixed.

I still think, however, that we ought to be able to deal with lost
interrupts.

johannes

--=-9zCgB0rekHq8jzA1eaNJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHV8FaVg1VMiehFYAQJypg//Q/uyZD2nBmZmqte7QsmJ4hjfOjP8H+T7
iCPlFUDiC26VLpkd4to03TuoCMrgCNgv2h22bitUyrrVxouO/C707OCLLRTPzhW/
dMdanchRBomlBSD/EPUZdA2QcNpIWM/sYctsMCYZUTQtTG95BQRcDR46ggL+C3z+
hlPPvN1ajNRNniq3ef/9eYebIlFZSWAqKcb7P0O4Ayny866i4QwJzPTewyk6Rmwk
9mGcCwbNY8anUyRZcX91FX/DSFinDaiYxr1bRdCe/23PkcCrn+L25HvlX45Vq2GL
TFIjereGYtgJwSbz2Us5ZacN9dNJy49S/l3Ym+On8HiGh+0qmHK3zTx0o/ret6Je
AWFW8iiY9NHpfhClejHdSNoLlwo1osJsD0P2nMV17pe24Fn9eNK+MVXGN2JrNBtg
obenHtETdAa5Uu20iHhMpQazm1IA7WgFSw4pw/PUZXEh77M/3mkoOjnJ3v3rpvKP
C4sbHPRYgZZ4I8iO4dcH1dCFgaLySrWnxh83enTa/eECk1goGsjazQbVeXl9024N
A/Xb1zmCUcCfUIFmP1kpJM1sN2sUecGlkNGXT1ptZViHvPAPhORv0FgrPXDm8pDW
7EytsvZiOhXVlCi8CeVnK5VZNeGGwAJieloRxvQgp/098KbZOx+cPABhAarew3Ch
lPa41M1gs5k=
=EyEB
-----END PGP SIGNATURE-----

--=-9zCgB0rekHq8jzA1eaNJ--
