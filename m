Return-Path: <mbuesch@freenet.de>
Received: from mout1.freenet.de (mout1.freenet.de [194.97.50.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C34D668704
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 08:37:33 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Linus Torvalds <torvalds@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Date: Sat, 12 Nov 2005 22:37:16 +0100
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
MIME-Version: 1.0
Message-Id: <200511122237.17157.mbuesch@freenet.de>
Content-Type: multipart/signed; boundary="nextPart1388875.tcmuNVc8HF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: linuxppc-dev@ozlabs.org,
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

--nextPart1388875.tcmuNVc8HF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 22:00, you wrote:
>=20
> On Sat, 12 Nov 2005, Michael Buesch wrote:
> >=20
> > Latest GIT tree does not boot on my G4 PowerBook.
>=20
> What happens if you do
>=20
> 	make ARCH=3Dpowerpc
>=20
> and build everything that way (including the "config" phase)?

I did
make mrproper
copy the .config over again
make ARCH=3Dpowerpc menuconfig
exit and save from menuconfig
make ARCH=3Dpowerpc

The result of the build is:

  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o: In function `platform_init':
: undefined reference to `prep_init'
arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `u=
cSystemType'
arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_=
prep_type'
make: *** [.tmp_vmlinux1] Error 1


=2D-=20
Greetings Michael.

--nextPart1388875.tcmuNVc8HF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdmCNlb09HEdWDKgRAkN2AJ9vzqHidntpXbUrhDSMfK3QiyJYbwCgg2AE
Oll/uEGQ2i+usB7+Yr9NFgU=
=5kHs
-----END PGP SIGNATURE-----

--nextPart1388875.tcmuNVc8HF--
