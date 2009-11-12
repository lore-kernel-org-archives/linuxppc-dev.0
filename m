Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by ozlabs.org (Postfix) with ESMTP id BB440B7BA3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 07:36:44 +1100 (EST)
Date: Thu, 12 Nov 2009 21:36:42 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCHv2 3/3] mpc52xx/wdt: remove obsolete old WDT implementation
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <20091112195646.GB13350@pengutronix.de> (from
	w.sang@pengutronix.de on Thu Nov 12 20:56:46 2009)
Message-Id: <1258058202.2192.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-Caat/X2NvlonSCJ70Af+"
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

--=-Caat/X2NvlonSCJ70Af+
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram:

Am 12.11.09 20:56 schrieb(en) Wolfram Sang:
> > Note: The file drivers/watchdog/mpc5200_wdt.c is now obsolete and shoul=
d be removed.
>=20
> Ehrm, this is possible within a patch :)

Ummm, I tried that (removed the file from git locally), but apparently I'm =
too dumb to find the proper options to get this into the diff (to my defenc=
e, I'm still using cvs/svn for my projects).  Can you give me a hint?

> >  config MPC5200_WDT
> > -	tristate "MPC5200 Watchdog Timer"
> > +	bool "MPC52xx Watchdog Timer"
> >  	depends on PPC_MPC52xx
> > +	help
> > +	  Use General Purpose Timer (GPT) 0 on the MPC5200 as Watchdog.
>=20
> s/5200/52xx/ here too.

Yes, you're right.  The config option should still be 'MPC5200_WDT', though=
, as otherwise all the default configs had to be touched - IMO, on the low =
level, this does no harm.  Thoughts?

Cheers, Albrecht.

--=-Caat/X2NvlonSCJ70Af+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBK/HHan/9unNAn/9ERAvMSAKDI8DKZ6ClhJjJHLV3JyOPcIWtZvgCeJjCI
LmmIyPoS0c8SBlEN6sJVb1E=
=c+ac
-----END PGP SIGNATURE-----

--=-Caat/X2NvlonSCJ70Af+--
