Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8687567B3F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 23:02:12 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/8] snd-aoa: add i2sbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hpshl5dhh.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115847.420788000@sipsolutions.net>
	<s5hr7274ox2.wl%tiwai@suse.de>
	<1149592647.5928.49.camel@johannes.berg> <s5h8xoamliv.wl%tiwai@suse.de>
	<1149680421.3999.4.camel@johannes> <s5hwtbt5ea8.wl%tiwai@suse.de>
	<1149684301.3999.21.camel@johannes> <s5hslmh5dwl.wl%tiwai@suse.de>
	<1149684747.3999.24.camel@johannes>  <s5hpshl5dhh.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XWkuc/fwHKlhcRGZ8VHd"
Date: Wed, 07 Jun 2006 15:01:49 +0200
Message-Id: <1149685309.3999.27.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XWkuc/fwHKlhcRGZ8VHd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 14:58 +0200, Takashi Iwai wrote:

> Well, I don't understand what you mean "side-effect" here.
>=20
> The device pointer is passed to the memory allocator, so if you pass a
> bogus value there, it'll cause surely oops.

Ok. I misunderstood what the function does. Sorry for the noise and
thanks for explaining.

johannes

--=-XWkuc/fwHKlhcRGZ8VHd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIbOOqVg1VMiehFYAQKI3BAAvkeipNdJc+J5Ew0fcmNXYHs0WeEw74bL
KPlCmUB3HZrD9WAemgsNYe7Z0+FYT3S2I7xf9aThAGnXFzwmmybbzfqc+KV8wLVu
N5xXH9dSWErE+VapjK45PgMwrUmmXpnWFaZfMscqKqMUYLBmWzSvrDQGNRcIHGs/
XweI5cfxGmVLB9DjArf9CNMg1RT2TDpon5h6+yiYumExz2k8dBTs/RNfzUn8l0FG
UqMXYr8WzfkR5DBi6+vINrLrsylu4UA66JhUoH9bg3+MqnBfPswD2ofzRDsM70qb
uJGcstTObrBvUNrf5GNRlkiTiMVG/HeMMvdORFKQBFad20Ydn1otnNFnWrxsZ68E
d4sScd/aVxN3t2cCN8JdCFFByAEQ5q4/E7wy5k407PyyWxnmQmiADP35rdZ6OubQ
nnEuwb9Qo0OCU4jS0xDsQ6QlBkMgBIknd8AE4gvNTGTKiTAz5GzsfPSNgDCdhGJE
CIHp4nCCsFWAxm/fUa9uvwU0Bz2CmluEP74buSJj7bkhIVodpXzt8Gu0cmFLQzpJ
9nL8Hf61ueJia7a96lbdJw83zGvVtzKhaO76DSmEqqXy6Jfxmz33/8IQCIaX/ozs
yohTsMBadERTLnJ5efvZ+l0UDlt2qZTv6btqUKp75O9ECTFYz2Czsvyi5uvlPcwr
Fe3gJA76rWc=
=+UfD
-----END PGP SIGNATURE-----

--=-XWkuc/fwHKlhcRGZ8VHd--
