Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 097BFDDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:48:55 +1000 (EST)
Subject: Re: [PATCH] snd-aoa-i2sbus: use MODULE_DEVICE_TABLE instead of
	plain	MODULE_ALIAS
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hr6r9shrq.wl%tiwai@suse.de>
References: <1175080700.5151.56.camel@johannes.berg>
	<s5hr6r9shrq.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uP8p1DseXFouaMM16++p"
Date: Thu, 10 May 2007 17:51:16 +0200
Message-Id: <1178812276.3806.25.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uP8p1DseXFouaMM16++p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 2007-03-28 at 13:56 +0200, Takashi Iwai wrote:
> At Wed, 28 Mar 2007 13:18:20 +0200,
> Johannes Berg wrote:
> >=20
> > This patch changes snd-aoa-i2sbus to use MODULE_DEVICE_TABLE instead of
> > a hardcoded MODULE_ALIAS. Thanks to Sylvain Munaut for pointing this
> > out.
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> >=20
>=20
> Applied to ALSA tree now.  Thanks.

What happened to this patch? It seems it hasn't shown up in Linus's tree
yet, but IIRC it's required with some modalias changes from Sylvain.

johannes

--=-uP8p1DseXFouaMM16++p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGQz90/ETPhpq3jKURAnFwAKCFlCXDlEuzjSHudF0Oi1BennCheACfbr1e
mliImBxjNZdNJRMXdA6yjXw=
=ZH0/
-----END PGP SIGNATURE-----

--=-uP8p1DseXFouaMM16++p--
