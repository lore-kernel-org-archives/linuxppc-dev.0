Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 77D1CDDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 00:41:47 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so2325766nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:41:46 -0700 (PDT)
Date: Wed, 17 Oct 2007 16:41:43 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: can and mpc5200b
Message-ID: <20071017144143.GI4859@sfrouter>
References: <20071015133233.GB4859@sfrouter>
	<f87351060710150705l5e4d1ba5v6806686cd25418bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
In-Reply-To: <f87351060710150705l5e4d1ba5v6806686cd25418bb@mail.gmail.com>
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


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello list,

> > Hello Friends,
> > what is the reasonable can-driver for a mpc5200b?
> >
> > I have seen for the peak-3.17 driver a port for the mpc5200 from denx o=
n their
> > website, but with kernel 2.6.23 I dont have a chance to use this?
>=20
> Check this out http://developer.berlios.de/projects/socketcan/ . This
> is the CAN driver we use and it works pretty well for us. It is very
> updated and supports the mscan chipset that is available with the
> mpc5200b.

Socketcan works for me perfectly with the canconfig tool.
Thank you.

Silvio


Mit freundlichen Gruessen
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHFh8m8WEBxatmn40RAkolAJ92C8bcRxFCUwD7IY6Am26OmiSVXwCgm1Wf
/7tJBS7qYDzzscKFm4BWV2s=
=/JfU
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--
