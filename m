Return-Path: <stefan.eletzhofer@inquant.de>
Received: from gonzo.webpack.hosteurope.de (gonzo.webpack.hosteurope.de
	[217.115.142.69])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77C2F688A1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Dec 2005 22:35:18 +1100 (EST)
From: Stefan Eletzhofer <stefan.eletzhofer@inquant.de>
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vVLmyMjjMQ5Z6+Cj2Qpe"
Date: Fri, 16 Dec 2005 12:16:37 +0100
Message-Id: <1134731798.11277.10.camel@localhost>
Mime-Version: 1.0
Subject: MPC5200 TXRTS feature
Reply-To: stefan.eletzhofer@inquant.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-vVLmyMjjMQ5Z6+Cj2Qpe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
has anyone got the "TXRTS" feature working on the Freescale MPC5200? I
need that to use PSC6 for RS485.=20

I've tried some hints I found in a thread starting here:
http://article.gmane.org/gmane.comp.hardware.motorola.microcontrollers.cold=
fire/6225
but no luck, so far.

I got it working by manually asserting and negating RTS through OP1/OP0,
and waiting for the TX_FIFO_EMPTY bit, but I really want to use the
TXRTS feature, which _should_ deassert RTS automatically one bit-time
after the last bit is shifted out.

Thanks,
Stefan E.

--=20
Stefan Eletzhofer
InQuant GmbH
Bahnhofstra=C3=9Fe 11
D-88214 Ravensburg
http://www.inquant.de
http://www.eletztrick.de
+49 (0) 751 35 44 112
+49 (0) 171 23 24 529 (Mobil)
+49 (0) 751 35 44 115 (FAX)

--=-vVLmyMjjMQ5Z6+Cj2Qpe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDoqIV20PMGlcwuNARArKdAKCZg6c9WLiiCANq5Emz5qYXw7nGUgCeM/F4
FSdAPAR0J1UaNz3lJ9vlC6U=
=bHxu
-----END PGP SIGNATURE-----

--=-vVLmyMjjMQ5Z6+Cj2Qpe--
