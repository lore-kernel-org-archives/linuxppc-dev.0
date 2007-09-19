Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id ED4C6DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 21:59:58 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so163369nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 04:59:57 -0700 (PDT)
Date: Wed, 19 Sep 2007 13:59:53 +0200
To: linuxppc-dev@ozlabs.org
Subject: Configuration-Problem ext-interrupt on mpc52xx
Message-ID: <20070919115952.GF5682@sfrouter>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

how can i configure an "ext interrupt" to high-level? I want a interruption=
 on
IRQ2, but I checked with an oscilloscope that the pin has a low state and I
needs a high state.

I have tried, after I got the irq (with irq_of_parse_and_map), set it with

    set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);

But I think it is a system-configuration (irq_desc) and no
device-configuration.

Mit freundlichen Gruessen
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8Q848WEBxatmn40RAvupAKCgsHGBFehNjS8j0Xi80WJbSHFK3ACg+Jw0
rSf1WOEV7pEayqQZvFzbTUk=
=ymkk
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
