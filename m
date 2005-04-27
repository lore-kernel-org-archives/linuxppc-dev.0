Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 7262C67B16
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 02:39:02 +1000 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: PPC_LINUX <linuxppc-embedded@ozlabs.org>
In-Reply-To: <609724aa0424d00c851e3d085ce6d56f@freescale.com>
References: <1114609634.30649.14.camel@ad.doubleclick.net>
	<609724aa0424d00c851e3d085ce6d56f@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rBeCTQD28LFJq9WWdSBC"
Date: Wed, 27 Apr 2005 12:38:58 -0400
Message-Id: <1114619938.4115.0.camel@ad.doubleclick.net>
Mime-Version: 1.0
Subject: Re: MPC8xx Platformization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-rBeCTQD28LFJq9WWdSBC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-27 at 09:42 -0500, Kumar Gala wrote:
> Jason,
>=20
> Two comments:
> 1. put mpc8xx_devices.c & mpc8xx_sys.c in arch/ppc/syslib (I moved the=20
> 85xx ones here and its where 83xx & 52xx are)

Ok.

> 2. can we just use hard coded offsets for start & end values.  I really=20
> hate assuming that the global immap_t structure is always correct.  I'm=20
> assuming on 8xx these values really aren't changing, take a look at=20
> mpc83xx_devices.c

No problem. I'll get another patch out soon.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-rBeCTQD28LFJq9WWdSBC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCb8Ah8/0vJ5szK6kRArIpAJwPXsSIv5MBBds+D50XXBPbw/3aKwCgo03i
nBKvOVH4DvjLwztyOaxpJ7Y=
=mAXS
-----END PGP SIGNATURE-----

--=-rBeCTQD28LFJq9WWdSBC--
