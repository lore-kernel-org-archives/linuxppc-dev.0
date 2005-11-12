Return-Path: <mbuesch@freenet.de>
Received: from mout2.freenet.de (mout2.freenet.de [194.97.50.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9E446873C
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 10:14:49 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 13 Nov 2005 00:13:45 +0100
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<1131834254.7406.43.camel@gaston>
In-Reply-To: <1131834254.7406.43.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart35388533.skd0ZB2N8m";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200511130013.45610.mbuesch@freenet.de>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: asm/delay.h missing on powerpc (was: Re: Linuv 2.6.15-rc1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart35388533.skd0ZB2N8m
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 23:24, you wrote:
> =C3=8Ct should still work. I'm running -rc1 with "powerpc" on mine so tha=
t at
> least works, it's possible that we broke "ppc", I'll have a look and
> send a fix.

powerpc arch builds and runs now, but
I have problems compiling the bcm430x driver. It includes linux/delay.h.
linux/delay.h includes asm/delay.h, which does not exist.
What to do now?

=2D-=20
Greetings Michael.

--nextPart35388533.skd0ZB2N8m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdncplb09HEdWDKgRAkYPAJsHxod/e8y4MY1892gcWqqMkzfJRgCdGbc8
oUpxsllA+Duypvur1BVQujY=
=/+wy
-----END PGP SIGNATURE-----

--nextPart35388533.skd0ZB2N8m--
