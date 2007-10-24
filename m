Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12664DDF17
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:15:20 +1000 (EST)
Received: from [131.234.199.55]
	by sipsolutions.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67) (envelope-from <johannes@sipsolutions.net>)
	id 1Ikg4n-0004Uj-Od
	for linuxppc-dev@ozlabs.org; Wed, 24 Oct 2007 14:15:14 +0100
Subject: ioctl32 unknown cmds with 2.6.24-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xXX4coWOjr2o0lOh9VC6"
Date: Wed, 24 Oct 2007 14:30:45 +0200
Message-Id: <1193229045.4510.35.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xXX4coWOjr2o0lOh9VC6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been getting these warnings (many more of them but this is a list
of unique ones) on my quad G5 with 32-bit userspace:

ioctl32(cdrom_id:1078): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg(000=
00000) on /dev/.tmp-3-0
ioctl32(ata_id:1095): Unknown cmd fd(3) cmd(0000030d){t:03;sz:0} arg(ff8639=
70) on /dev/.tmp-3-0
ioctl32(smartd:3563): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(ffeb54=
80) on /dev/sda
ioctl32(hald-probe-stor:3761): Unknown cmd fd(4) cmd(00005320){t:'S';sz:0} =
arg(00000004) on /dev/hda
ioctl32(gnome-terminal:4187): Unknown cmd fd(19) cmd(0000530b){t:'S';sz:0} =
arg(0fd8e400) on /dev/pts/0

Does anybody know whether this is expected?

johannes

--=-xXX4coWOjr2o0lOh9VC6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx869aVg1VMiehFYAQLzyg/8CD77h2m1sBbmHssmX6j6YMngHxlm1M4E
+O5A8vpO/AXY6WKMDjSY5LDeqUCoHtWrmwQEcKwrCmAnGLt5pTlCFXPW9CQFpRGA
pWPhkXgOFAytJOYYUCoS37vU/T76yavnnEwJFwOGYW9GULK281JA7uWjWYI88fbc
KDg6S2Q6cpDecYgeuLVvJ851Kx0YoU2yLHy74lX9s2aS3MRsZesM3bF105DgmKWl
vUeBCV7eYP4Hn9f/FqNYlNPjE25+Iit9VL0FwZJYWOVakpEZd2Kc2K+yrRTfyUbR
8kvSB/W9QEI91IJRrpy0jlZCAXQ94ZqlTyx0uaKBnZ87ry7f9ohl4WhGexqvbNe5
5iRpFE2ADB3LpBg/IVwNBD4s+5YEsEAUJNSs6DNKSrqh5ZjkzZLcIK7WSqOA3Ceb
eKuOJO3BZ0ApxrMDTNInDd4EhEr0QrqSfkyUcjxAGvhxxRJFBda9eO3KNVRUfUby
V9kt3ux2AF8JLKccCsOcnRwdybb30YvIVfhWIXBFuIs1DLgOcNrJiuE7sfwtzsEE
V3hf4gx+RhT0ZoYwtBzYRpKetRltNfZzZdRUJwy3ItCPfBVGz03ImHLBiaVyjBZK
HyuQPqVh4mQp7PzoGTEERYHEvuauDoG9+J7RXh3JRsGnmGkh0l6g81r+RP03VOSL
JCUhIYItHNw=
=rEGU
-----END PGP SIGNATURE-----

--=-xXX4coWOjr2o0lOh9VC6--
