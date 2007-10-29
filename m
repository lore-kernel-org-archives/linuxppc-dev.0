Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56BC6DDEE1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 19:10:54 +1100 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@insightbb.com>
In-Reply-To: <200710290109.49604.dtor@insightbb.com>
	(sfid-20071029_051039_383906_B85F6B29)
References: <1193222676.4510.5.camel@johannes.berg>
	<200710281054.31303.dmitry.torokhov@gmail.com>
	<1193584081.5197.17.camel@johannes.berg>
	<200710290109.49604.dtor@insightbb.com>
	(sfid-20071029_051039_383906_B85F6B29)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-U/7OQqO0x04F0tdxSZS/"
Date: Mon, 29 Oct 2007 09:12:06 +0100
Message-Id: <1193645526.5197.30.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Anton Ekblad <valderman@gmail.com>,
	Joseph Jezak <josejx@woodpecker.gentoo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-U/7OQqO0x04F0tdxSZS/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> OK then let's play safe and don't touch fountains at all. How about the
> patch below?

Looks fine to me, works with my fountain touchpad and should fix
Joseph's error too.

> Input: appletouch - idle reset logic broke older Fountains
>=20
> Fountains do not support change mode request and therefore
> should be excluded from idle reset attempts.
>=20
> Also:
>  - do not re-submit URB when we decide that toucvhpad needs to be
>    reinicialized
>  - do not repeat size detection when reinitializing the touchpad
>  - Add missing KERN_* prefixes to messages
>=20
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Johannes Berg <johannes@sipsolutions.net>

> ---
>  drivers/input/mouse/appletouch.c |  125 ++++++++++++++++++++++++--------=
-------
>  1 file changed, 77 insertions(+), 48 deletions(-)

johannes

--=-U/7OQqO0x04F0tdxSZS/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyWV1aVg1VMiehFYAQKimBAAnMz93JapAW6gVf4/+Tmw6OzfFabol/Ke
4S/oEpNWiw5vDDhRP4ZR4rV9qCrn+D6raOUgviKKok5sbnv9khpSfVlo/X4cMD+X
G9eXbEPsWcs2lMhXhSJRwqEds8J0tikb10vEQhHpVnqZyeMdn8ML7ilvbBfrAZ8M
lUw8x6iaPkDM4S7ucp4HpXGE41B2niKQm+QI4Pax9pXKmSwuRl7Xw/PQ9+O0j4KJ
957xPywO60GpKlHoOLrl+0jn07FIlGVoTZfzLxqXHlT8O8daF22gGIlZmqrZALYW
bnvDdCFvHx6ECL0ku2J4aqNMPXNfrqQvf6HESASa7R7vIm/Mv001tDRLA3GXlLgh
/jv/62+CsTxrEpFZG9PkJZaIfRLNzFcCIOwekatXtvF640WgpxXa/zvGAvJok6zg
4yXANaoknB7uVKi54ssWJ61bL9dILACzdmVLo0oE57CG1bDBNrZzJfqoYkvVyrgK
RFK09BHNkld9j4gbRzo6yLu7XT+VOA/eCrj0GUEib8r/l4RNpY3z6ulRcYS78bIj
ieWfcDeRFbIdzBuluwLnOAmxHCWaZTjlRzo1FIzex2YhPe0CEUH0o8ggINbBmyot
vS3pcQxyQrhW63sCZGOfqv7gWZ9deKHvsw9WwQFwoL9GyBZTGwGGEGEdfVaUvTNj
YTCGh05/Lpg=
=zY9x
-----END PGP SIGNATURE-----

--=-U/7OQqO0x04F0tdxSZS/--
