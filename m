Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1FCE1DDE04
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Feb 2007 04:38:49 +1100 (EST)
Subject: Re: [PATCH] powermac: proper time of day after resume
From: Johannes Berg <johannes@sipsolutions.net>
To: michael@ellerman.id.au
In-Reply-To: <1170470494.30263.0.camel@concordia.ozlabs.ibm.com>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.386891000@sipsolutions.net> >
	<1169620444.18754.66.camel@localhost.localdomain>
	<1170357390.4036.9.camel@johannes.berg>
	<1170470494.30263.0.camel@concordia.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BtN1efON946gbrOFNU1v"
Date: Sat, 03 Feb 2007 18:37:51 +0100
Message-Id: <1170524271.4629.15.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BtN1efON946gbrOFNU1v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-02-03 at 13:41 +1100, Michael Ellerman wrote:
> On Thu, 2007-02-01 at 20:16 +0100, Johannes Berg wrote:
> > This patch converts the time restore code from a PMU notifier to a regu=
lar
> > sys device so any powerpc platform will use it.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >=20
> > ---
> >  arch/powerpc/Kconfig                           |    5 +
> >  arch/powerpc/kernel/Makefile                   |    1
> >  arch/powerpc/platforms/powermac/time.c         |   38 -------------
> >  mb-wireless/arch/powerpc/kernel/time_suspend.c |   70 ++++++++++++++++=
+++++++++
>=20
> Would it be better in arch/powerpc/sysdev perhaps? :)

Well, I put it along with time.c :) But we can well put it into sysdev
as well, I don't really care.

johannes

--=-BtN1efON946gbrOFNU1v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFxMhv/ETPhpq3jKURApcQAJ9A2JZK+3xnRQ5gF1/NV2SPPI2fagCgmT+W
x4BhKd/4LgnCCqQYG02gFqk=
=mBwh
-----END PGP SIGNATURE-----

--=-BtN1efON946gbrOFNU1v--
