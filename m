Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id 91ABCDDEEC
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 21:26:26 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: Sven Luther <sven@powerlinux.fr>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Date: Mon, 4 Feb 2008 11:26:19 +0100
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
In-Reply-To: <20080204095121.GA18167@powerlinux.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5056204.R1bsX2K3pl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802041126.21989.bernhard@intevation.de>
Cc: debian-powerpc@lists.debian.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5056204.R1bsX2K3pl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 February 2008 10:51, Sven Luther wrote:
> On Sun, Feb 03, 2008 at 05:29:05PM +0100, Bernhard Reiter wrote:
> > Dear linux powerpc Maintainers and Users,
> >
> > recently I have tried to compile a new kernel on a Debian sarge ppc
> > system (PowerBook5,6 MacRISC3 Power Macintosh).
>
> This is a G4 based system.

Yes.

> > The build system bailed out with
> > =A0 =A0 =A0 =A0BOOTCC =A0arch/powerpc/boot/4xx.o
> > =A0 =A0 =A0 =A0 cc1: error: bad value (440) for -mcpu=3D switch
> > =A0 =A0 =A0 =A0 make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1
> >
> > I have tracked this a few steps and the attached patch made the compile
> > for me as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13)
> > cannot produce code for 4xx it seems.
>
> You should normally not need to build the 4xx bootloader part. Make sure
> that, i don't know why this happens. Can you look into
> arch/powerpc/boot/Makefile, to see what option enables the 4xx build,
> and make sure it is disabled in the main config ?

I have tried to do this, but it looks like it is just hardcoded into the=20
Makefile  as you can see from the patch. There is probably more that I do n=
ot=20
understand - thus my report with on the workaround.

Bernhard

=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart5056204.R1bsX2K3pl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHpuhNh9ag3dpKERYRAh+gAJwK7xCAAIgO1+jIo42GdrxCC+cD+ACbB/ox
5BJtxM8f3Bel0qW9PPZTnf8=
=dXg9
-----END PGP SIGNATURE-----

--nextPart5056204.R1bsX2K3pl--
