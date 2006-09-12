Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F7FA67A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 01:33:24 +1000 (EST)
Received: from igloo.df.lth.se (localhost [127.0.0.1])
	by df.lth.se (8.13.1/8.13.1) with ESMTP id k8CFXI15010256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Sep 2006 17:33:18 +0200 (CEST)
Received: (from roubert@localhost)
	by igloo.df.lth.se (8.13.1/8.13.1/Submit) id k8CFXHUc010246
	for linuxppc-embedded@ozlabs.org; Tue, 12 Sep 2006 17:33:17 +0200 (CEST)
Date: Tue, 12 Sep 2006 17:33:16 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: linuxppc-embedded@ozlabs.org
Subject: How to move from /ppc/ to /powerpc/
Message-ID: <20060912153316.GC16340@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have a custom board on which I currently run Linux 2.6.18-rc6
configured for MPC834x_SYS in the /ppc/ tree, which just a few minor
changes. Now I'm interested to move to using the /powerpc/ source tree
instead, but I can't figure out exactly what steps are necessary to do
this.

Does anyone run a MPC834x_SYS built with ARCH=3Dpowerpc?

I boot the board with U-Boot (version 1.1.4, customized), and I assume
that I need to add some stuff for this new device tree thing, but I
can't figure out exactly what the kernel will expect.

Does anyone have some pointers on how to do this?

Cheers // Fredrik Roubert

--=20
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (SunOS)

iQCVAwUBRQbTPMRKuLhQMn35AQKAMQP+MVWVppYNwWoHB2hx6OXIrjAKiqgJ83qO
WOgvIpqFbz8Wq32iVfRibUiPBUVkM+Kp9PG39kF5v5Ck58C06NyBohJZcyi/XEha
Fh9JpZzHgVCnQ5spJOwiORQnVvsaC9u2YgWlrOAZduwQckotWDSDrfuOJPuaGDmO
gmUTx7p25I8=
=zkGt
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
