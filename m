Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B220A679A6
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 21:40:42 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/8] snd-aoa: add i2sbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h8xoamliv.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115847.420788000@sipsolutions.net>
	<s5hr7274ox2.wl%tiwai@suse.de>
	<1149592647.5928.49.camel@johannes.berg> <s5h8xoamliv.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kVm5kANYzkNIlmR1UOSp"
Date: Wed, 07 Jun 2006 13:40:21 +0200
Message-Id: <1149680421.3999.4.camel@johannes>
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


--=-kVm5kANYzkNIlmR1UOSp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-06 at 16:00 +0200, Takashi Iwai wrote:

> > Yeah, I guess, never really thought about that, just wrote it down the
> > way I thought to do it :) That said, I think it's more readable if
> > written that way, do you want me to change it regardless?
>=20
> I found a single if is more readable (and good for compiler).

Heh ok, I'll change it, it isn't really hard to read either way.


> No, the only requirement is that you have to call snd_pcm_lib_malloc()
> with proper type and assigned device pointer if you use
> snd_pcm_lib_malloc() function.  (If not called, you've got an error
> when compiled with debug option.)

Ok, but how do I set the device pointer?

johannes

--=-kVm5kANYzkNIlmR1UOSp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIa7I6Vg1VMiehFYAQJmHg//at37v5bgqpcMevzHP9D6Dmf2BlR13v+f
oWfVslsUcG0Ad1lcvyK0jzOBJ7NBIGaIOoeZwNfeBpVIM5TEvTfuL/qE/rI/NgvK
QuwLV97R35v9TKmSS6dBYkzp3BAI6ELQ/T1U2tRwOwJPaDObfJD9HOqz6asjiX0T
boAiaJ/w4XvAKjTZlWCTIcKtjMqESIyHAGhSBK/yzIhawcckRFeJPhhROcGg9b+X
skdOZC2huI7fb6t/7qdQRa6o6aeryPN93zouDUvUpo+NWv+4zTV0ZrbtbIRYX2xr
0N8y0Cg/sOmkGRC+Jat7Aue9yMMbJs8wdv3tLCKoZvkB4HxVSp3E8rWiNE+yYcLA
1JetURCHgtbv2Ak+pRQHt2LqKIAVaW2twNuXo1WJa582/UESJPCUgrZnNIzDfIjS
dfS09i8RcCTe1chPxoXOV9eGMG03sWY7bDMrd7TbsIdgztmuWmXX0ihTHWaqHD/T
x9qxngN4vWrCuUznEtYdKbBV5s83/8CHgOSQs63AxT6OCMmi0QlQcWy7q4LbnQDg
xULILf+8bxz1Src8WMykuRgUU26PKfNOWMnMZRbUkV8eCt7TrLQA1RQEIVVKhB4e
YJksuur82h8hZtnnlHCySULR0VkG7PQWL8PN3i0ZIKgGTbjlVDlSQQORuPnfULU8
6SE+YT6xT9Q=
=KrS8
-----END PGP SIGNATURE-----

--=-kVm5kANYzkNIlmR1UOSp--
