Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4495DDECB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 02:29:33 +1100 (EST)
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080222095022.GA635@ingate.macqel>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ryMVtFjGN8fgnTGT/YuF"
Date: Fri, 22 Feb 2008 16:29:11 +0100
Message-Id: <1203694151.7082.37.camel@johannes.berg>
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


--=-ryMVtFjGN8fgnTGT/YuF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I wonder why a kernel configured for E500 and compiled by a E500-specific=
 gcc
> triggers this message.  Is it invalid to use SPE instructions in the kern=
el=20
> or do I misunderstand the message ?

I think it's like floating point/altivec, we don't always save the FP
registers on kernel/userspace transitions and so have to explicitly save
them to use them in the kernel, otherwise we'd clobber the userspace
register state.

I guess there's something like kernel_enter_spe()?

johannes

--=-ryMVtFjGN8fgnTGT/YuF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR77qRaVg1VMiehFYAQK4XBAAgkmjt580rPMhZnb8HEFWYKwy2YXeT65c
jI7i/m4Uhht9JDUPaM9ctDbysygYKPnQSrtBq7xhC5kKrHEJ7NVe4guAuYnYzuZA
wHjimAuCT3GWgWP3vAUtaOkBA/5J+s4bll0YsaTvwtmoeo5wmwx8RkMUevw5vI3V
RE2tSD3hBwJiY1yNm6uKfhfzN9PEiqNuLu2yiMsfBmy4wtG9bn+XLsRvD7R4yQxt
bmuB0PNZX/hRaRvIY7sEyUsgqksgZNir74ElPO92UnCBld/uK7nqJoOz52fDnR5S
0vSPWQoiJ1FTAN/wYc5w8jYKoHibPMUTfa9LjkTx32mLWZc07/isPsN1XKOQ6EjA
KP/aye1p+jNdyKta+3DsbqejbyL6D2WxpKFHpnDl9c8Kw36n4qfpDYMMve91s06v
u6d4DzIhnLjQcPQALzJLanTAwt9sOx9lzfoWgf6ih19EK3gpsKCx/DtIt4WzikcD
lK3WTm8UUFke4vmU4ZVzptN1bt485P9SHNgIHlPTzUptYcXRv5I+t5a4MhNuok/w
hsUKuBN3PLU/j/tMavpQTGIejVJBNHnpKD1nhXSlPyukvGKiuHLt5x/vkKEKTGYI
6xyhHAThOIWMwgJO2wT/1dMcpefil8FhtN2AfCWnpu6ZAy6Nia4707cPfem+zN+Q
pnAyCKvL/+Y=
=AuVl
-----END PGP SIGNATURE-----

--=-ryMVtFjGN8fgnTGT/YuF--
