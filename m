Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id 1C36EB7BA0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 07:33:30 +1100 (EST)
Date: Thu, 12 Nov 2009 21:33:19 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCHv2 1/3] mpc52xx/wdt: OF property to enable the WDT on boot
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911121106j1d609868vb16d6867955aa607@mail.gmail.com>
	(from grant.likely@secretlab.ca on Thu Nov 12 20:06:03 2009)
Message-Id: <1258058006.2192.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-uYlxlcf/JSjU/d7LWO/D"
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-uYlxlcf/JSjU/d7LWO/D
Content-Type: text/plain; charset=UTF-8; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant!

Am 12.11.09 20:06 schrieb(en) Grant Likely:
> > +The watchdog will respect the CONFIG_WATCHDOG_NOWAYOUT option.
>=20
> I think it would be better to use a device tree property to enable up
> NOWAYOUT.  The static config isn't multiplatform-friendly.  Thoughts?

I fully agree with you that this property would fit perfectly in the device=
 tree.  However, if we now add it *only* for the 52xx, but not for other de=
vice tree-aware platforms, this might be somewhat confusing.  The good thin=
g is that it wouldn't break =20
anything for the 5200 as the old wdt driver didn't work anyway.

One *real* advantage of the compile-time option is that it actually removes=
 the code which stops the wdt.  I'm not a real expert in that, but if we ar=
gue that the system is "safe" as required by IEC/EN 61508 part 3, it's prob=
ably beneficial if we can show =20
that there *is* no code to stop the wdt, not a snipplet only disabled by a =
flag.

Just my =E2=82=AC0.01, though - maybe more insight from the WDT gurus?

Cheers, Albrecht.

--=-uYlxlcf/JSjU/d7LWO/D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBK/HEWn/9unNAn/9ERAmTnAKCUVjZhNQKzMmzUTcZIkVSlToMDmwCePG5E
3rrjOPalLiJZyLXqTeTZAf0=
=5Acg
-----END PGP SIGNATURE-----

--=-uYlxlcf/JSjU/d7LWO/D--
