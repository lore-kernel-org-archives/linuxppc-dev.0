Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 26A6BB7BF3
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Oct 2009 00:40:31 +1000 (EST)
Date: Sat, 3 Oct 2009 16:40:26 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-15?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc/5200: make BestComm gen_bd microcode exchangeable
Message-ID: <20091003144026.GA27519@pengutronix.de>
References: <20091003094417.GA24206@pengutronix.de> <1254577821.3331.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <1254577821.3331.0@antares>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> doesn't give any support, so it's all trial and error and error and =20
> error...  If you have any idea, pointers would be appreciated!

Sorry, I hardly know anything about the microcode. From what I know, it
shouldn't be much fun due to various bugs in the Bestcomm engine.

> I don't think so - the message body is a "format=3Dflowed" (RFC 3676) =20
> text/plain part.  Maybe your MUA doesn't display that format correctly =
=20
> (Outlook?)?

Hey! No need for insults! ;)

Have to check if my MUA (see headers) supports it. The archives seem to have
split it as well:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/076236.html

I recall a similar problem, where some archives had the patch correct and s=
ome
didn't.

> Or is '3676 in general not acceptable for patches?

Maybe. Could you try without next time, and we will see if it works better?

> P.S.: Did your mtd-ram/physmap_of patch you submitted a while ago make =
=20
> it into the stock kernel?  I have some pending extra work (16-bit LPB =20
> RAM access) building on top of it...

Yup, since -rc1. (git log --grep=3Dmtd-ram)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrHYloACgkQD27XaX1/VRtvJgCgl/oS/cNitfMPRRVPZ4gIk8IW
cnMAnRDqkBe0jndZS3/PKRfV3NoUjQct
=doeL
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
