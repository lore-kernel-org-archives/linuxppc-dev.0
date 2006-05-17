Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC57F67A45
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:39:47 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hd5ec4yn7.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<s5h7j4m40kf.wl%tiwai@suse.de>
	<1147817023.6753.5.camel@localhost.localdomain>
	<s5hy7x10y5t.wl%tiwai@suse.de> <1147868218.15507.4.camel@johannes>
	<s5hd5ec4yn7.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0mzGBs7DpD3dLdh7VguY"
Date: Wed, 17 May 2006 14:39:37 +0200
Message-Id: <1147869577.15507.17.camel@johannes>
Mime-Version: 1.0
Cc: ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0mzGBs7DpD3dLdh7VguY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 14:35 +0200, Takashi Iwai wrote:

> The question is where to implement a huge table or a complex
> conversion function -- whether in the driver or in alsa-lib.

Well if it was in the alsa-lib I could just give it a formula that
contains an exponential and some constants, and that's all it needs. But
in the kernel it has to be a lookup table since I can't do floating
point math easily.

johannes

--=-0mzGBs7DpD3dLdh7VguY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsZh6Vg1VMiehFYAQL9BxAAxGXCzbkZ8T5EThYGDaATmQjCBdsiCGY3
roI8CkeiKJVoPcjhubLoUbNQRLtSZ03/JWkZnZMbM7U8IpnJT/cMzp0HoQwgXI5Y
nf13RH1sYgtMnsHQXjhpirBYRpCLP6S/3GyLJ/t0UCuV0ZtLfFVwFDr7zZ9jHG6b
Gl/Y52HD8gQa3RHjblGxJkULAmdM1S9xHeH5ibKaOxFU2zOCRreuyb2CEGl1FDJw
AUHPqL3TbqVgPT+P4tPlMQm6ikfGUXpNnYk219aYA5H9czJsSlJFcI08ccRN8KOW
PvbSqDk1Y3fuxUPaY+345z3IezS3q3dfSFSnzC0EbYyYsXu8jwPWtB7Zmxv5wT0K
ARSGOmeZf3XcwYOcPTd0hxukgIs8R5m1W7Wa9Z1U3V5d0yxMxpftc+oazM6birVa
5UjZQELdIpySDzZo/4ND7eQxjv25X7SBNQisBfS+2Vwv6sMmlfB7U0LWQe82WkBR
gbS1UCJJZL2Owxay3/7LgzIVc6dDLQty3dOWeF8jBsHnMhlNN1HlAph7Q4j07i9W
UUSCGz9k2zQkZFygVDvPI2cTHexNUXl7RhwYki0qKhGISRDRJ7r2V66ssKPf7wRz
v9IY/Y8lRMzlotMcS+wq83DgJjJUOS2tdh2dXwIgwgCggQziqCp0hvxZEB/n+2MB
SP/G1w/cWSI=
=v+pD
-----END PGP SIGNATURE-----

--=-0mzGBs7DpD3dLdh7VguY--
