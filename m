Return-Path: <silvio.fricke@googlemail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id A5F90DDE17
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 18:37:02 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so499956fgg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 23:37:00 -0800 (PST)
Date: Thu, 17 Jan 2008 08:36:50 +0100
To: linuxppc-dev@ozlabs.org
Subject: Re: psc and spi
Message-ID: <20080117073650.GB32721@sfrouter>
References: <20080115135306.GE14333@sfrouter>
	<fa686aa40801150651s213a745dwa4d595de5a9d191b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
In-Reply-To: <fa686aa40801150651s213a745dwa4d595de5a9d191b@mail.gmail.com>
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


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HeHo,

> > I have on the psc3 the spi-interface of a fpga connected.
> >
> > [...]
> >
> > Can I use the mpc52xx_psc_spi-driver? And if yes, how I have to use this
> > driver?  Or must I write a own spi-master/slave thing? Can anyone point=
 me
> > to a good start-position?
>=20
> Yes, you should be able to use the mpc52xx_psc_spi driver.  You'' need
> to add the activate_cs and deactivate_cs hooks in your platform code
> to activate your SPI CS lines.  You'll also need to set port_config to
> have the PSC3 pins in "CODEC3" mode.

What is the mostly used way for that?

I think, firstly I must define a "fsl_spi_platform_data"-structure, for use
in a "platform_device"-structure. And now I register this "device" with
"platform_device_register".
Or what is the appropriate way?

Best Regards,
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkePBZIACgkQVoIVmOSKtD5sfQCfX7x7XjSNdAkz+GRJH3yqOfy6
HHgAnRGiDkOeilaYGBRDjzu7/8h3P7LD
=fAsV
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
