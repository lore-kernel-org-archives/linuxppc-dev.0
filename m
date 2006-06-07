Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D905567B21
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 22:45:23 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/8] snd-aoa: add i2sbus
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hwtbt5ea8.wl%tiwai@suse.de>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115847.420788000@sipsolutions.net>
	<s5hr7274ox2.wl%tiwai@suse.de>
	<1149592647.5928.49.camel@johannes.berg> <s5h8xoamliv.wl%tiwai@suse.de>
	<1149680421.3999.4.camel@johannes>  <s5hwtbt5ea8.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dQojHrsawxNKwE308fej"
Date: Wed, 07 Jun 2006 14:45:00 +0200
Message-Id: <1149684301.3999.21.camel@johannes>
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


--=-dQojHrsawxNKwE308fej
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 14:41 +0200, Takashi Iwai wrote:
> > Ok, but how do I set the device pointer?
>=20
> Your code already does it.

Where? Am I just missing something? I don't see where I use pci_to_dev
nor setting any device pointer.

The thing the comment noted was that if I left out the call to
snd_pcm_lib_preallocate_pages_for_all, it would later oops somewhere.

johannes

--=-dQojHrsawxNKwE308fej
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIbKSqVg1VMiehFYAQJlYQ//eLK2cGsZYCK+UO2QJ4pxc9F09+KAN4Js
L6YfS8rRd8AltL1qz3aTPONdRiGu2FWJdLSgx5Igo4n1j8Bbp+pjyIplP/9vaJMG
x697Dw84/RC/7M7dnVXqP+jsV6nqxRx8gQwlNHyO5RgY8RTFTQEKT3eha3kADIlQ
Ft92hlpW59bhY9tD6uHctsPQrOw3GutKtZWm2erDhOmqSgRG1vkWfpRzrOL5K71r
EQeU9qUpdO6cpHByJivAlWwbgh9LUSxZFhbt/jPwxKsI7JUb0TLOVgGzYiDJwX75
jeqw01puOx4Pq5sy9GYOBSa8wHp5bbugn+OsoU5dCr7mBDRNOcZlGe9nHPkldtHy
xfQozkMISKWq7MTezLSbxQS7d2fsW2XI4Fsj7cdbC1caD6koSY6snTWXOhY8nY6G
o1ndrG+HPfnuM8ZDqU55rj1nkHE1nIkut7I66Q7kzZFGa1U3fPC3yk9CoxPFSTop
kjZRyvUmkPLLe++sPiBrx8/0SVoeWldNJzW7c3U6f3cX8n+GPUB24Cf73EKPifPw
05SH6NfdcW67zfzP0VGT7LwphF5DF5KYlfVkydF6otrHAD/RJUiINfGCv10d0V4n
8SmHXzwjKig2s8cPX4/GZd44WlZeSnyE430qspsvdDz7EOhaNkJI+N6OgnCdthxd
iXDzBfPsMoE=
=HeSz
-----END PGP SIGNATURE-----

--=-dQojHrsawxNKwE308fej--
