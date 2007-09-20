Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id D0539DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 18:37:52 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so421005nfd
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:37:50 -0700 (PDT)
Date: Thu, 20 Sep 2007 10:37:46 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: Configuration-Problem ext-interrupt on mpc52xx
Message-ID: <20070920083746.GL5682@sfrouter>
References: <20070919115952.GF5682@sfrouter>
	<fa686aa40709190809v284618d4r65674a1409ab0b57@mail.gmail.com>
	<20070919190146.GI5682@sfrouter>
	<20070919234016.GA14404@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
In-Reply-To: <20070919234016.GA14404@localhost.localdomain>
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


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> > I have read it! But another driver on Boot-time pulled my interrupt
>=20
> Erm.. if the interrupt is shared with something else which expects a
> different trigger/polarity, you're kind of stuffed....

YEEeess! An incomplete documentation is suboptimal! In german, we would
say: "[...] Das es die Sau krausst [...]"

I have now used an another Interrupt and it works.

Mit freundlichen Gruessen
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)                   TEL:       (+49)8330-911278
   Linux-Entwicklung                       JABBER:      fricke@jabber.org
-- Steinbacher Strasse 18, D-87764 Legau -----------------------------------


--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8jFa8WEBxatmn40RAk9KAJ9edfmndtdAjMrCBWJp9FIW4nfQjACguQ/5
Z+yRE+9Y7JL8R4ulgVO7wLw=
=TSsS
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
