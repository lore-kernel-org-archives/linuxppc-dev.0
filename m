Return-Path: <marc.leeman@gmail.com>
Received: from lmailproxy02.edpnet.net (lmailproxy02.edpnet.net [212.71.1.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CB91DDE27
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 21:16:32 +1000 (EST)
Received: from chiana.homelinux.org (213.219.137.24.adsl.dyn.edpnet.net
	[213.219.137.24])
	by lmailproxy02.edpnet.net (8.13.1/8.13.1) with ESMTP id l549uim7012794
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 11:56:45 +0200
Received: from marc by chiana.homelinux.org with local (Exim 4.63)
	(envelope-from <marc.leeman@gmail.com>) id 1Hv9IZ-0004f7-3B
	for linuxppc-dev@ozlabs.org; Mon, 04 Jun 2007 11:56:27 +0200
Date: Mon, 4 Jun 2007 11:56:25 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 83xx GPIO/EXT int in arch/powerpc/
Message-ID: <20070604095625.GF17456@chiana.homelinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GdbWtwDHkcXqP16f"
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--GdbWtwDHkcXqP16f
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I am moving my boards from arch/ppc/ to arch/powerpc/ and am trying to
use the MPC83xx_IRQ_EXT? pins.

The device (hardcoded to use 23 as with the arch/ppc/ config, EXT7)
does not signal the ints to the CPU.

The only reference I find to this usage in arch/powerpc/ is in
arch/powerpc/platforms/83xx/mpc834x_itx.h, which is most likely
something left over while moving from arch/ppc/

Probably, I need to enable them in the dts tree (?) but since it's a PCI
device that uses a GPIO pin for signalling interrupts, I'm trying to
find out where and how to configure this.

Is there some example for e.g. an 83xx board how to configure one of
those external interrupt pins?

--=20
  greetz, marc
It's like Disney on acid! Ten years of really great sex all at the
same moment.
	Crichton - Rhapsody in Blue
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--GdbWtwDHkcXqP16f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGY+HIUQpj09NWLeERAu5kAKCwqB1HSYEqMggUM3rF2yzQVz6f2QCfZA7V
F/fBQD6AB6wzUaiol32Oz5s=
=1c6a
-----END PGP SIGNATURE-----

--GdbWtwDHkcXqP16f--
