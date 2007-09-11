Return-Path: <silvio.fricke@googlemail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.236])
	by ozlabs.org (Postfix) with ESMTP id BBE98DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 23:48:14 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 24so586580hud
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 06:48:13 -0700 (PDT)
Date: Tue, 11 Sep 2007 15:48:08 +0200
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interrupt-problem mpc5200
Message-ID: <20070911134808.GK11807@sfrouter>
References: <20070910090305.GG11807@sfrouter> <12613692.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
In-Reply-To: <12613692.post@talk.nabble.com>
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> Hello,
>=20
> Is it possible that this call failed?
> intr =3D ioremap(MPC52xx_MBAR+MPC52xx_INTR_OFFSET, MPC52xx_INTR_SIZE);=20

That call did not fail, but you are right
I have forgotten this snipped

    if(!intr) {
        panic(__FILE__ ": mpc52xx-pic - MAP failed");
    }

Thank you!

Silvio


Mit freundlichen Gruessen
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
----------------------------------------------------------------------------


--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG5pyY8WEBxatmn40RAkwKAJsGhdkickTt9ZWmqR2p/RslRrgdFwCfQGjS
9OWYOsNiQuK3f1WIX1FknrM=
=rAFE
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
