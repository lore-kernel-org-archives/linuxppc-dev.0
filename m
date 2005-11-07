Return-Path: <wolfi@mittelerde.physik.uni-konstanz.de>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D53268679
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Nov 2005 02:15:27 +1100 (EST)
Date: Mon, 7 Nov 2005 15:54:33 +0100
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: Charles-Edouard Ruault <ce@idtect.com>
Message-ID: <20051107145433.GA15372@halley.zuhause>
References: <1130999620.4680.28.camel@gaston> <436F1A9E.80105@idtect.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
In-Reply-To: <436F1A9E.80105@idtect.com>
Cc: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Charles-Edouard,

On Mon, Nov 07, 2005 at 10:13:02AM +0100, Charles-Edouard Ruault wrote:
[...snip...]
> Hi Ben,
> i've applied your patch and it seems that when i put my powerbook to
> sleep ( by closing the lid ) the kernel just crashes since everytime i
> come back, the machine is turned off. I had a look at the logs and i see
> that i'm having a reboot almost immediateley after the lid is closed.
> However i've got no trace of a kernel panic .....
> my conf:
>=20
> Linux kaluha 2.6.14 #1 PREEMPT Mon Oct 31 10:28:22 CET 2005 ppc GNU/Linux
> processor       : 0
> cpu             : 7447/7457, altivec supported
> clock           : 612MHz
> revision        : 0.1 (pvr 8002 0101)
> bogomips        : 406.52
> machine         : PowerBook5,2
> motherboard     : PowerBook5,2 MacRISC3 Power Macintosh
> detected as     : 287 (PowerBook G4 15")
> pmac flags      : 0000001b
> L2 cache        : 512K unified
> memory          : 768MB
> pmac-generation : NewWorld
>=20
> I have a usb mouse that i unplug before closing the lid.
> Anything else that can be usefull ?
> Thanks for your time.
> Regards.

In a recent email to this list, Benjamin Herrenschmidt wrote:
> > >
> > > I would say your first mistake is to use PREEMPT :) There are
> > > various
> > > issues with PREEMPT on ppc32 that have not really been addressed so
> > > far,
> > > and the USB code has some "holes" that I wouldn't trust in a PREEMPT
> > > environment.
> > >
> >
> > What do you mean exactly? Should CONFIG_PREEMPT not be used?
> > And what about CONFIG_PREEMPT_VOLUNTARY?
>=20
> I would avoid both for now.
>=20
> Ben.

If I interpret your version string correctly, you also havre preemption
enabled. Please try without and report back success and/or problems.

With best regards,

Wolfi


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDb2qpH0o2mefAfsQRAgWgAJwN1Bb2G/uaBjWlKKVmAQLceOUmOwCdEeb1
0kOzo1XI49wWQV6RND++ImY=
=5IjG
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
