Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 918EB67A00
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2006 04:32:49 +1100 (EST)
Received: from [131.234.77.74] (helo=dhcp-77-74.uni-paderborn.de)
	by sipsolutions.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.60) (envelope-from <johannes@sipsolutions.net>)
	id 1FJvqY-0004eH-LT
	for linuxppc-dev@ozlabs.org; Thu, 16 Mar 2006 17:01:10 +0000
Subject: i2c-bus@0 twice?
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-N19pmEfQOV+Zd/Xy/EBa"
Date: Wed, 15 Mar 2006 19:29:57 +0100
Message-Id: <1142447397.4670.12.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-N19pmEfQOV+Zd/Xy/EBa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

johannes@quad:/proc/device-tree/ht@0,f2000000/pci@8/mac-io@7/i2c@18000$ ls
AAPL,address       built-in     i2c-bus@0         linux,phandle
AAPL,address-step  compatible   interrupt-parent  name
AAPL,i2c-rate      device_type  interrupts        reg
#address-cells     i2c-bus@0    linux,device      #size-cells

Somewhat odd that i2c-bus@0 exists twice :) Anyone have an explanation?

johannes

--=-N19pmEfQOV+Zd/Xy/EBa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARBhdI6Vg1VMiehFYAQKW6w//Usid6dFEJcKBZ5U95JYRKLH1meBjwAC6
eZ1wvjvZGh2aOUK/+9Qgd+ccFUBhMcHEvRJ+18yYB82+Ab3x+yrdMbqsmH6qfQdV
gRwsX0PXAghRt7ZXGIlRkmMxUwrdfA3ne1Hw5i2brXNkCMaBmRLR07kolEYUwdex
zM2uFndg2X8ldyOHvIWLX/6qOKP1z+rCYSleAi3oPOC9RDQDyA8xJtwtBTgIDvAW
lG0HDWrF92zo05SXSVfUoi01dRxZIr6AhEHFNvtJX8pI5XmWxuATWX9Yd0iIQrxn
hI6Pv2x9SGSc3SteXttdJfkLs9yoKTYhqAwcp0fexdodg6c7yfhb33n1p41GL8Jo
FK2TQKnx17jG7rd31PTcsBzZ4cS2HAa3e2Eu38OvQ2CmiYP8sAZxpr9p1HiOEbYy
AOYTfeXaQyTWDFuNNRK9qFW+wA5MBvr+2Pd0XavaReiPmDN8NZGuMzs9pzMhfxq5
08ddo7wTRvwWEylFq1rr3Hqvs75RHe4jSJd3ds4vvPUcjY22jVXMWUiLSu+f4DKJ
YGIgpeqkY/2gTXQN+3lzHzOaY49JOdEr2scVqRn/GhbrnPyS8DbC7r+jtdmc8d/N
CSOjjh4HbY0d9BgCX8/rqhl7XWjU8lxE/uVkKQq/VDGnerRVEfEZ/8JG+j7z4nBO
LO6e1uOEHuI=
=mOrI
-----END PGP SIGNATURE-----

--=-N19pmEfQOV+Zd/Xy/EBa--
