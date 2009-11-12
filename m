Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3FF78B7BA0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 07:47:14 +1100 (EST)
Date: Thu, 12 Nov 2009 21:47:09 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCHv2 3/3] mpc52xx/wdt: remove obsolete old WDT implementation
Message-ID: <20091112204709.GC13350@pengutronix.de>
References: <20091112195646.GB13350@pengutronix.de> <1258058202.2192.1@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
In-Reply-To: <1258058202.2192.1@antares>
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


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2009 at 09:36:42PM +0100, Albrecht Dre=DF wrote:
> Hi Wolfram:
>
> Am 12.11.09 20:56 schrieb(en) Wolfram Sang:
>> > Note: The file drivers/watchdog/mpc5200_wdt.c is now obsolete and shou=
ld
>> > be removed.
>>
>> Ehrm, this is possible within a patch :)
>
> Ummm, I tried that (removed the file from git locally), but apparently I'm
> too dumb to find the proper options to get this into the diff (to my defe=
nce,
> I'm still using cvs/svn for my projects).  Can you give me a hint?

git rm file

You can even do this after you removed the file using rm already. 'git stat=
us'
gives you an overview about the current changes and how to add them to the
commit.

> Yes, you're right.  The config option should still be 'MPC5200_WDT', thou=
gh,
> as otherwise all the default configs had to be touched - IMO, on the low
> level, this does no harm.  Thoughts?

I'd also leave the config name. But the help text should match the prompt :)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr8dE0ACgkQD27XaX1/VRs+EQCgwi9Wmhwu/iZ3mHzhhoGkYCGR
i9IAnRawnRecC3OBrdknb8EustO8iMlk
=GtmB
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
