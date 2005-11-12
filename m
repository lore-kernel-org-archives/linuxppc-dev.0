Return-Path: <mbuesch@freenet.de>
Received: from mout0.freenet.de (mout0.freenet.de [194.97.50.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D55B6872A
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 08:57:41 +1100 (EST)
From: Michael Buesch <mbuesch@freenet.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Sat, 12 Nov 2005 22:57:05 +0100
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<20051112215304.GB21448@stusta.de>
In-Reply-To: <20051112215304.GB21448@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1267883.nDEaAvpfZ1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200511122257.05552.mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1267883.nDEaAvpfZ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 22:53, you wrote:
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   CHK     usr/initramfs_list
> >   GEN     .version
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/powerpc/kernel/built-in.o: In function `platform_init':
> > : undefined reference to `prep_init'
> > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference t=
o `ucSystemType'
> > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference t=
o `_prep_type'
> > make: *** [.tmp_vmlinux1] Error 1
>=20
> Please send your .config .


I did this in my first mail:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D113182883102937&q=3Dp5

=2D-=20
Greetings Michael.

--nextPart1267883.nDEaAvpfZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdmUxlb09HEdWDKgRAk1yAJ9Zw1PylO0oCkhLNjODh840edv1QgCfaPkj
elXJPo3dLwfaAJtoCmXyWSk=
=WJF4
-----END PGP SIGNATURE-----

--nextPart1267883.nDEaAvpfZ1--
