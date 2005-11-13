Return-Path: <mbuesch@freenet.de>
Received: from mout1.freenet.de (mout1.freenet.de [194.97.50.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01EFB68733
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 20:55:54 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 13 Nov 2005 10:54:56 +0100
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511130013.45610.mbuesch@freenet.de>
	<1131841993.5504.13.camel@gaston>
In-Reply-To: <1131841993.5504.13.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3634148.6pZZ8ZopEJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200511131054.57289.mbuesch@freenet.de>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: asm/delay.h missing on powerpc (was: Re: Linuv 2.6.15-rc1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3634148.6pZZ8ZopEJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 13 November 2005 01:33, you wrote:
> On Sun, 2005-11-13 at 00:13 +0100, Michael Buesch wrote:
> > On Saturday 12 November 2005 23:24, you wrote:
> > > =C3=8Ct should still work. I'm running -rc1 with "powerpc" on mine so=
 that at
> > > least works, it's possible that we broke "ppc", I'll have a look and
> > > send a fix.
> >=20
> > powerpc arch builds and runs now, but
> > I have problems compiling the bcm430x driver. It includes linux/delay.h.
> > linux/delay.h includes asm/delay.h, which does not exist.
> > What to do now?
>=20
> I suspect that building drivers out of tree doesn't work very well with
> the new "merged" architecture where includes are split between asm/ppc
> and asm-powerpc... You should make sure that you build the driver with
> the same ARCH as the kernel, that is ARCH=3Dpowerpc at least, if we got
> the Makefiles right, that should give you all the headers...

Call me an idiot ;)
doing make ARCH=3Dpowerpc in the driver works perfectly fine.

> (building glibc is definitely a pain :)

Try out the stable LFS book. It will guilde you trough it step by step. ;)

=2D-=20
Greetings Michael.

--nextPart3634148.6pZZ8ZopEJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdw1xlb09HEdWDKgRAk9KAJ9ePo45WGpXv8ElCgophtT7etUc3ACcCbr6
eq3DYspW1NYS7UmXigjm1JI=
=4UVH
-----END PGP SIGNATURE-----

--nextPart3634148.6pZZ8ZopEJ--
