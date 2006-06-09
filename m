Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 644C967C03
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 22:14:06 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 05/12] snd-aoa: add i2sbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hfyig4xhm.wl%tiwai@suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130913.414650000@sipsolutions.net>
	<s5hfyig4xhm.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MXlkpVwJ6LUTgZrbbEZR"
Date: Fri, 09 Jun 2006 14:13:49 +0200
Message-Id: <1149855230.3864.19.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MXlkpVwJ6LUTgZrbbEZR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:44 +0200, Takashi Iwai wrote:
> > +	if (I2S_CLOCK_SPEED_18MHz % (rate * mclk) =3D=3D 0) {
> > +		if (!i2s_sf_mclkdiv(I2S_CLOCK_SPEED_18MHz / rate / mclk, out)) {
>=20
> I'd use "I2S_CLOCK_SPEED_18MHZ / (rate * mclk)"

Yeah, I guess that's clearer then if the multiplication is there twice.

> release_resource() doesn't kfree the record returned from
> request_mem_region(). =20

Hah, ouch. I'll go through and fix them all.

> ALSA has a helper function
> release_and_free_resource() that also does NULL check and kfree:

Why's that helper in alsa of all things? :)

johannes

--=-MXlkpVwJ6LUTgZrbbEZR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIll+6Vg1VMiehFYAQL9AA//YJxAj0dxE5vzEc1TvNa24sZvB73BSs9p
ctSB+CFZh0AJOAhXNvhWTvfPlmlU0pVtOHUaqTP3kLYnLIaTXNiml+NNflVqtnX/
u8u/e6mV/j80GrXLw19Mbzfo20HhETfj2Q0C35ZGc+5GkXGXmlTruGarTHX4kmZS
E5yrYWMs5xCcxFPwczVdhyunst84TIi9Nu26vdswnvOgjEd+kOuVWdIh747aHYii
QAP16983sg5K4OM9Go7hqGQzugaIFJWYhHzzkrqD1ra6qz71qPWyQv9F+wrMTCBk
OdXo2vBlshoh1grfvPDyU3DNTNDJ3oQ9iFI3rznpltolc1l8419in76CDW2Uglwl
cScPbVHqGci5vj2c5GVl5lDDN7x353eTUcNNsjdeXyeu9EQT791UbLqoPQqH5SJu
0mGAvYOnTf9eiXtY35RXWZCHGEO1A2OYn8YP6cqNgDdZOUITVJIjskGGO20k+SNs
XxNAfoSTZwjv+dI+okPYLI+SeXDpSnxMQ/BpA0rrbYD8/51g2coIpbt5jRG6Yr47
M6a/bxktLUvKvZRsQY5cZVKN/Bev+/HmVLDz+Z/RFrBlq5ii1+rz9xfX6rt69vrC
wdK+09YtC6k3ZEOREmIWuTbW6TipW1qbVwc7/6RzUNRIF64pmWgpnRB2lPho2Zbl
uUxLqDLc8U4=
=+ct0
-----END PGP SIGNATURE-----

--=-MXlkpVwJ6LUTgZrbbEZR--
