Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E5AEFDDE2B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 07:48:24 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175721656.4640.3.camel@shinybook.infradead.org>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
	<1175691839.2774.11.camel@shinybook.infradead.org>
	<1175706447.7388.13.camel@johannes.berg>
	<1175721656.4640.3.camel@shinybook.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SAAbRJy/ZXYrKq59Y8Hx"
Date: Wed, 04 Apr 2007 23:48:02 +0200
Message-Id: <1175723282.7388.44.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SAAbRJy/ZXYrKq59Y8Hx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-04 at 17:20 -0400, David Woodhouse wrote:

> Not sure if the subsequent patch was expected to change anything or not,
> but it doesn't...

Which patch are you referring to? The one you updated wasn't supposed to
change anything here. In fact, we've not actually restored the context
for suspend to disk forever ("fix suspend states again").

>  $ dmesg | grep -i adb
> PM: Adding info for platform:adb.0
> adb: starting probe task...
> adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
> ADB keyboard at 2, handler 1
> Detected ADB keyboard, type ISO, swapping keys.
> input: ADB keyboard as /class/input/input1
> input: ADB Powerbook buttons as /class/input/input2
> ADB mouse at 3, handler set to 4 (trackpad)
> input: ADB mouse as /class/input/input3
> adb: finished probe task...

> adb adb.0: suspend
> adb adb.0: LATE suspend
> adb adb.0: EARLY resume
> adb adb.0: resuming
> adb: starting probe task...
> adb devices: [2]: 2 c4 [7]: 7 1f
> ADB keyboard at 2, handler 1
> adb: finished probe task...

Right. I really haven't got a clue what this may cause. I'm trying to
find something but haven't so far.

johannes

--=-SAAbRJy/ZXYrKq59Y8Hx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFB0S/ETPhpq3jKURAgUsAJ0WI+qhydGUnocS9vP1H9ws8KfZyACdFLWh
VuOLrh6pWjBrU2XSknhixm4=
=JUcY
-----END PGP SIGNATURE-----

--=-SAAbRJy/ZXYrKq59Y8Hx--
