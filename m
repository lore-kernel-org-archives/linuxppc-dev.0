Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 05996DDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:41:43 +1100 (EST)
Date: Wed, 20 Feb 2008 10:41:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Message-Id: <20080220104133.e9722e62.sfr@canb.auug.org.au>
In-Reply-To: <47BB63AE.2090903@pikatech.com>
References: <4784FED1.2040206@pikatech.com>
	<20080219092321.1fed233d@hyperion.delvare>
	<200802190959.41253.sr@denx.de> <200802192355.17707.arnd@arndb.de>
	<47BB63AE.2090903@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__20_Feb_2008_10_41_33_+1100_G/Aiar9XIDssyV+m"
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__20_Feb_2008_10_41_33_+1100_G/Aiar9XIDssyV+m
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -       depends on IBM_OCP
> > +       depends on IBM_OCP || PPC_MERGE

not PPC_OF?  or even OF (give the sparc guys the opportunity to build it
for us :-))?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Feb_2008_10_41_33_+1100_G/Aiar9XIDssyV+m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHu2k1TgG2atn1QN8RApv/AJ9A2Ys0Jw1+al8jHdl1BVBXzqJXqgCglOJe
cT7tMCzxoy1qC3j/yAaxgbY=
=tJcJ
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Feb_2008_10_41_33_+1100_G/Aiar9XIDssyV+m--
