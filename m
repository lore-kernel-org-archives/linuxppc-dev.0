Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id EC95367BF8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:23:51 +1100 (EST)
Date: Mon, 11 Dec 2006 19:23:47 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/6] [POWERPC] 8xx: Add support for FSL 8xx, 885ads and
	86xads eval boards
Message-ID: <20061211192347.47700906@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_u3./yTk=s3jdqpYs+jQ7Fb.";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_u3./yTk=s3jdqpYs+jQ7Fb.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable



The following series intended to port the 8xx boards support to arch/powerpc
together with mpc885ads and mpc86xads reference boards. It features regress=
ion-less=20
transaction (all the peripherials work, namely SMC1,2 UARTs, FEC1,2 or SCC3=
 Ethernet
for 885ads for instance).

It is pretty extended comparing to the original stuff because all the comme=
nts were addressed+
added support of 86xads family.

--
Sincerely, Vitaly

--Sig_u3./yTk=s3jdqpYs+jQ7Fb.
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFfYYUuOg9JvQhSEsRAv8MAJ9CCEa60RsAzvtaqR+aolpm5ITgywCeIo/0
MDt4hZ9rD6OwdVanKGsdvBg=
=vdjc
-----END PGP SIGNATURE-----

--Sig_u3./yTk=s3jdqpYs+jQ7Fb.--
