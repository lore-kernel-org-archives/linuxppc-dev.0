Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 56355DEC8A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 01:51:04 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 49E568914
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 17:51:01 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 2A95C889D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 17:51:01 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: How to pass information from the bootloader to the kernel ?
Date: Thu, 10 Apr 2008 17:50:58 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14076405.ItTkxmXivr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804101751.00618.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart14076405.ItTkxmXivr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I need to pass a limited amount of information from the boot loader to the=
=20
Linux kernel, such as the boot mode chosen by the user or the last boot=20
reason (power up, reset, watchdog, ...).

What is the best way to pass that kind of information from the boot loader =
to=20
the kernel ? Should I use the device tree ?

I thought about populating the chosen node with the data I need. This could=
=20
make sense for the boot mode, but I feel like I would abuse the chosen node=
=20
if I used it to pass other "non user chosen" information.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart14076405.ItTkxmXivr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH/jdk8y9gWxC9vpcRAjIRAKCJM0++1wVWJjfby8SYX9w2TYnlEQCgvo/3
68TK4JI+NRI7HJP5o4HOapI=
=dSXc
-----END PGP SIGNATURE-----

--nextPart14076405.ItTkxmXivr--
