Return-Path: <pavel@ucw.cz>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxpVb0SMrzDrFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 22:40:52 +1100 (AEDT)
Date: Thu, 8 Mar 2018 12:40:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Linux 4.16: Reported regressions as of Monday, 2018-02-26 (Was:
 Linux 4.16-rc3)
Message-ID: <20180308114047.GA21514@amd>
References: <CA+55aFxk5KBxL9DvRtBivP3hKT-aOAzvSA_B47L1+y0P2GLe_A@mail.gmail.com>
 <2cf45d87-066c-7368-3fbd-20675f2d74ae@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <2cf45d87-066c-7368-3fbd-20675f2d74ae@leemhuis.info>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Nokia N900:/dev/input/event6 aka AV Jack support disappeared
> Status: quite new
> Reported: 2018-02-24
> https://marc.info/?l=3Dlinux-omap&m=3D151950886524308&w=3D2
> Cause: 14e3e295b2b9
> Linux-Regression-ID: 4b650f

This one is now solved in the mainline.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqhIT4ACgkQMOfwapXb+vIIEACghtvM/o5EyRWWP0QQcBR5P8Tw
gUsAn12TknudoZMCR94RRuO8e9B7wSjI
=hlBj
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
