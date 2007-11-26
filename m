Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id D073EDE4E3
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 04:35:41 +1100 (EST)
Date: Mon, 26 Nov 2007 09:35:44 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: Access to PCI Expansion ROMs on PPC
Message-ID: <20071126173544.GI14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<20071125194101.GD14557@curie-int.orbis-terrarum.net>
	<20071126085928.GE14557@curie-int.orbis-terrarum.net>
	<1196068814.22865.108.camel@thor.sulgenrain.local>
	<20071126102414.GF14557@curie-int.orbis-terrarum.net>
	<9e4733910711260833t5053ed5fu5227046565eae86b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
In-Reply-To: <9e4733910711260833t5053ed5fu5227046565eae86b@mail.gmail.com>
Cc: Michel D?nzer <michel@tungstengraphics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2007 at 11:33:00AM -0500, Jon Smirl wrote:
> Did you check out the cards on x86 and ascertain that they have the
> standard PCI header in them? 55 AA .... All PCI ROMs are supposed to
> have that. If they are missing that the size code in the rom.c isn't
> going to work right.
See my more recent testing summary post to the list, with the message-id
of 20071126085928.GE14557@curie-int.orbis-terrarum.net
(http://ozlabs.org/pipermail/linuxppc-dev/2007-November/046880.html)
The X1900 and Nvidia OF-based cards do not turn up on the x86_64 box at
all (the PCIe root node is entirely missing with them as well), and the
sata_mv claims to not have a ROM, but does otherwise work.

> If these are OF ROM and you are booting on OF firmware, the ROM is
> getting run. In that case it may not be so simple to turn them back on
> if they have been hidden using a proprietary register. That's the
> quirk BenH has referred to.
That's the path that I was investigating with the register stuff via
airlied's avivotool. There was one register he thought about, but it
didn't seem to do much.

I also found some instructions to try and view the ROMs from inside OF,
some I'm going to try that later today, as that will enable seeing if
Linux is changing something critical.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFHSwPwPpIsIjIzwiwRAtZ0AJwI8wpkIiXx/Rf750kktXbb6UP6ZACfbtnJ
o8NCx+RcSgkclUzvyGv8TC8=
=IFk7
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
