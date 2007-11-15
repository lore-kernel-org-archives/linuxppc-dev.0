Return-Path: <silvio.fricke@googlemail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 2C4D0DDE05
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 23:52:32 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so576869nfd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 04:52:31 -0800 (PST)
Date: Thu, 15 Nov 2007 13:52:26 +0100
To: linuxppc-embedded@ozlabs.org
Subject: Re: /sbin/init: error while loading shared libraries:
	libm.so.6:cannot open shared object file: No such file or directory
	[Scanned]
Message-ID: <20071115125225.GC6019@sfrouter>
References: <1195129440.10980.7.camel@linux-2drc.site>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
In-Reply-To: <1195129440.10980.7.camel@linux-2drc.site>
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


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> I have a problem with booting the uRamdisk image from eldk 4.1 on an
> TQM5200 (MPC5200 CPU) board.
> I have taken the uRamdisk image from the "/eldk/ppc_6xx/images" folder
> and copied it to the flash. After booting the following output came
> after the Kernel boot:
>=20
> Freeing unused kernel memory: 64k init
> /sbin/init: error while loading shared libraries: libm.so.6: cannot open
> shared object file: No such file or directory
> Kernel panic: Attempted to kill init!
>  <0>Rebooting in 1 seconds..
>=20
>=20
> An image from eldk 3.1.1 is working fine with the Kernel 2.4.25.
> The files libm.so.6 and libm-2.3.5.so are available in the /lib folder.
>=20
> Does anyone has an idea, what this could be?

This is a problem of handling the eldk. Please contact the eldk-ml on [1].

[1] http://lists.denx.de/mailman/listinfo/eldk

Bye!
eS.eF.

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung                       JABBER:   silvio@jabber.ccc.de
----------------------------------------------------------------------------


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHPEEJ8WEBxatmn40RAmaDAJsEMdkqUyoyLkNVSV8tJ4sSwOz1BQCcDAnS
cMgKj5lIixvW4WFYtc8LbpE=
=xMJb
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
