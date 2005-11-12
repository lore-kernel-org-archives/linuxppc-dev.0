Return-Path: <mbuesch@freenet.de>
Received: from mout1.freenet.de (mout1.freenet.de [194.97.50.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71BCC68739
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:33:17 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 12 Nov 2005 23:33:02 +0100
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<1131834336.7406.46.camel@gaston>
In-Reply-To: <1131834336.7406.46.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6796073.SN3GBMp4uK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200511122333.03010.mbuesch@freenet.de>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6796073.SN3GBMp4uK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 23:25, you wrote:
> On Sat, 2005-11-12 at 22:37 +0100, Michael Buesch wrote:
> > On Saturday 12 November 2005 22:00, you wrote:
> > >=20
> > > On Sat, 12 Nov 2005, Michael Buesch wrote:
> > > >=20
> > > > Latest GIT tree does not boot on my G4 PowerBook.
> > >=20
> > > What happens if you do
> > >=20
> > > 	make ARCH=3Dpowerpc
> > >=20
> > > and build everything that way (including the "config" phase)?
> >=20
> > I did
> > make mrproper
> > copy the .config over again
> > make ARCH=3Dpowerpc menuconfig
> > exit and save from menuconfig
> > make ARCH=3Dpowerpc
>=20
> You need to disable PREP support when building with ARCH=3Dpowerpc for 32
> bits, it doesn't build (yet). We should remove it from Kconfig...
>=20
> Also, there is an issue with the make clean stuff, make sure when
> switching archs to also remove arch/powerpc/include/asm symlink before
> trying to build.

Ok, thanks Ben.
ARCH=3Dpowerpc without PREP builds and boots.

=2D-=20
Greetings Michael.

--nextPart6796073.SN3GBMp4uK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdm2elb09HEdWDKgRAusWAKCf3QeP3D/nxyRg0bik+jq/AoAz1ACgmffJ
nv3AyqH10iyJzSjonW8XirM=
=UGvS
-----END PGP SIGNATURE-----

--nextPart6796073.SN3GBMp4uK--
