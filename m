Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7319679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 28 May 2006 06:07:16 +1000 (EST)
Subject: Re: [PATCH] make ams work with latest kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20060526173908.GA3357@ucw.cz>
References: <1148383943.25971.2.camel@johannes>
	<1148465069.6723.26.camel@localhost.localdomain>
	<20060526173908.GA3357@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ANRVqCZSfU/zOXn2j/VX"
Date: Sat, 27 May 2006 22:06:54 +0200
Message-Id: <1148760414.16989.59.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ANRVqCZSfU/zOXn2j/VX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 17:39 +0000, Pavel Machek wrote:

> > This driver also provides an absolute input class device, allowing
> > the laptop to act as a pinball machine-esque joystick.
>=20
> Is it useful to have /sysfs interface when we already have same data
> available as joystick?

Might be useful if you need to turn off the "joystick" because X gets
confused with it. Other than that, no.

johannes

--=-ANRVqCZSfU/zOXn2j/VX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHixXKVg1VMiehFYAQIt8g/+KTCerGwZtfWmQSywGmf6Iz+kCVPqI9YF
TKPPzv8fsu+Jw5PY4VnuCBEu7szT48hB7nDElJTpk+pgcx85cDlxNxXdZBOy0t5z
oRVx4PRUbMUMNIuQVMiZCVDlmmNRF0NjuoZCoIllqA7kZbnBUXARV+H3mlLoGKu9
9nGUgI8K+qKSanGhnEfzUKliUCYpW8MBMfl5A6nx8ky5ksVlLewUJKYGFeupy3sC
7Tn0seLoAZejDFVUN0Q0HsJ0WH4v6Vxg1F7nb1EzYkynysFvRTzxwGVR2pro3JKW
HsPVNeHeMKtRoNMlx9yP08E3YJzO068aRen2Pf0y7zY6fHYUHNcxGbP3EA6BzdOo
bgyR+6MRW/tCQui1Giw+b0o3KwOjXLWF7nTUUuIF3L+UI3JFCTtxFBabXTtkpq3M
fmqXfnTKnSP1hP+wCjBJmq87/GrFfLiPzHVFol5WaRIFKUvnT8aREknJwEQxRApC
63TxLjlCStiWx9qoFaWBo+nkq3lZkaHaiJgL8eb75h5F4XemQs9g5/PXixmqDkl5
CdUYkAY2WmrFp3Y2trEiaKNKGKPLsc2JtLdmOZvBv0WVI+YqKJcY8psNlpQ/c6uW
gaXBsXKSSd8u/7H/nFgsESMpVX1JB156fEfObYM1DSjWxT21vYd3cuBMCoMCNb2K
bci/E3dpAWQ=
=tvZ2
-----END PGP SIGNATURE-----

--=-ANRVqCZSfU/zOXn2j/VX--
