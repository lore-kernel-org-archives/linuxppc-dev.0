Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 038CADE229
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:38:04 +1000 (EST)
Subject: kernel stops booting on quad powermac
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-r7CbPr/jBgJcBL+TTgk1"
Date: Mon, 15 Oct 2007 16:56:34 +0200
Message-Id: <1192460194.3349.47.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-r7CbPr/jBgJcBL+TTgk1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Oddly, a recent kernel (23fd50450a34f2558070ceabb0bfebc1c9604af5) stops
booting at "windfarm: Drive bay control loop started.", while previously
"windfarm: CPUs control loops started" was displayed a long time, i.e.
Backside took very long to start.

Haven't had a chance to look into it yet, any ideas? I do have NO_HZ
enabled. I wanted to test the irqtrace patch but I doubt it would be
causing this, usually bugs there caused hangs very early, not this late
in the boot sequence.

johannes

--=-r7CbPr/jBgJcBL+TTgk1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxN/oaVg1VMiehFYAQI8NRAAsKWQ/jbxfd4Ow4qzLE8fV3+31rJbSTBg
1Oqw/aySVd1H/pRK/K2hsozq/myB618LhmIgQvgkb1q7m9DSlmvkRhWxp9I7iz0Y
4jlSW+fvE8jS4RcHNZ3XVGJ0zyqtO1HtUNl5NwYnwTymbiTgjOpCVt168uY8XR4E
7xOYy5CFqCOzeXnpa6OZjuvZJZglwqluEbgKy96n535GOdaukkoL/d144zHv8YwS
n59XOZZyszQe+dlEQoT7xYUhmetcfqWR9AnUkELDQPkama9qiywWfR/4NElSaC5T
6ffcf9Pu6UlMSFHqY+lWS01mSr33EmhVxLmskMNciIiMW5b6R8rtzTv4S9hYhWMa
IbjAoTtswOH+N1JRuedyY5e2f1RoL0UH2vghIiOAaTFr3IyS+HJ4xIjccexOfh1H
zffMUySDfE5x56jZkrsdnzEZwF443ys800MpGgRODqi8Bc0/OuAzFWEHif8Lhiam
fSc1E8rbM/unPeG3rfFBh7ILzUlwvOTYkleuNG3jsfMohBpmMH37hvuFRpAWWyQy
bzpoZKX1HmWIn4JLG9ELqaTwZoH9tTEGuBjYK1cHBT6vH+YsOLU7NKKPOLbnt4wx
lc2rIaPWJEWfN5Ag/WnIcZR/xE44Iome+UBKiBDBbrtROJ0tgcXE/CVfz5xyatCz
TJusghl/+aU=
=/l3c
-----END PGP SIGNATURE-----

--=-r7CbPr/jBgJcBL+TTgk1--
