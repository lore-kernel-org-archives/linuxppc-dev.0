Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 609C3474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 02:41:49 +1100 (EST)
Subject: Re: adding more machines to snd-aoa
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20081023153510.GA28277@iram.es>
References: <1224769461.6002.12.camel@johannes.berg>
	<20081023153510.GA28277@iram.es>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-u6STt5C0Y6htMrruDbwJ"
Date: Thu, 23 Oct 2008 17:41:02 +0200
Message-Id: <1224776462.6002.45.camel@johannes.berg>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux User #330250 <linuxuser330250@gmx.net>,
	Sjoerd Simons <sjoerd@luon.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-u6STt5C0Y6htMrruDbwJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-10-23 at 17:35 +0200, Gabriel Paubert wrote:

> On my almost 8 years old PowerMac (PowerMac3,4 accorfing to OF):
>=20
> $ find /proc/device-tree/ -wholename '*sound/device-id' | xargs hd
> 00000000  00 00 00 0e                                       |....|
> 00000004
>=20
> or 14 in decimal.

Cool. This thing uses snd-powermac, right? Can you tell me which devices
it has, like does it have line-in, microphone, headphones, ...?

johannes

--=-u6STt5C0Y6htMrruDbwJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJAJsKAAoJEKVg1VMiehFYxCoQAKp8J2Cr3ddndCLOASk5YhGT
kIuk+nRlstEElMT2U8CoKhRXSadFH9Qkp5iUsc/xsCi78zohV4oLnbPkahRsY70o
jKlUSBQsyKiHKV5ZRnlPZRIY9l8HaWvS5zTkxT3KfD3FfP3YXik/shsAMNDP6K0Q
qM6SQiFazrSsJ8GIuNQDVpwAf/Zwx0xkqKC3Br/3Og099AKsgk6UyZGEzS5qyRCT
ZsBTkZATb/2vWaAWbbFCF96m5uPFMCDXaYm4hkAxLQGqM54vQJ403nwWlBeKH5fz
tRdjdEZKm2fMRHUw4T/cuHGoDjP91ikYoeiE++/zCHFk7G2CfzrRQoumqCeTi+NZ
jEjfuo6gNhB/PVtCRKrs+FLLF6AklGJhqUTcA0CTyjE1frPYH61Efi0Diz6yeE+C
p2W7bg+4E16O0cK/M9BBfrR5U8aw8hN5+6ThQ2G/x6mUpm44m7vJXImewJ7kh5HY
mdQ5lDDJpdMWUm+ohMyo5w9ttn39okqjulwMYVTp2W6YCpW09D0z7H0NtMznPhSP
CpgKpLXP4m/4EGCsZN5H3x5vQvdwz8DdNsQYARlgcJkDshtcMfdlqENNVk+Fx4Le
/VxTDuf9BpvklBSi7suAx+pq0M0ti27lntGZmXsRac5haPRqQhKH+67yI9RF5QKU
Ai9GB4Tc+YhP6oLeKWYH
=SHuq
-----END PGP SIGNATURE-----

--=-u6STt5C0Y6htMrruDbwJ--
