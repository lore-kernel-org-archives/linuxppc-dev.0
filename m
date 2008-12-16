Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 963C4DDF8F
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 23:27:42 +1100 (EST)
Date: Tue, 16 Dec 2008 13:27:32 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Greg KH <gregkh@suse.de>
Subject: adding of_platform_drivers (was: Re: [RESEND][PATCH] uio: Add
	of_platform_driver to uio_pdrv_genirq)
Message-ID: <20081216122731.GC3275@pengutronix.de>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
	<20081211205033.GA7080@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
In-Reply-To: <20081211205033.GA7080@suse.de>
Cc: linuxppc-dev@ozlabs.org, hjk@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +/* -------------------------------------------------------------------=
--
> > + * OF bus binding
> > + */
> > +
> > +#if defined(CONFIG_OF)
>=20
> Same goes here, don't put #if in .c files please.

So, generally speaking, this means that I should not put a
platform_driver and an of_platform_driver into one source file, but
rather create an of_$DRIVER.c then? I found both ways used in the kernel
and could not find hints about the preferred way to do it. I took this
approach as I hoped it would save some code to directly convert the
of_node to uioinfo without the detour of using a platform_device
inbetween.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklHnrMACgkQD27XaX1/VRtqVgCeNRTrMgtmVHBqkfx84ili+hS7
6IQAnRgwJOng1yxbQ13jzEQPHJvfyRM2
=OZHf
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
