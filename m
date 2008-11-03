Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 47186DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 09:15:59 +1100 (EST)
Date: Mon, 3 Nov 2008 23:15:46 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] workaround for mpc52xx erratum #364 (serial may not be
	reset in break state)
Message-ID: <20081103221546.GA16244@pengutronix.de>
References: <490F51E7.3020309@unicontrol.de>
	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<490F73B5.6010004@genesi-usa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <490F73B5.6010004@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?iso-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2008 at 03:57:09PM -0600, Matt Sealey wrote:

> > Optionally you can further
>> reduce impact by checking if CONFIG_PPC_MPC5200_BUGFIX is defined.
>
> I would much prefer this.

I submitted a patch to enable pipelining on a MPC5200B recently. It was
disabled because of a bug in the MPC5200. The first version of this
patch used MPC5200_BUGFIX and it was mentioned, that some people might
want to run the same kernel on both kind of processors. So, the patch
that went mainline checks for the PVR. Maybe we should stick to this
here, too?

All the best,

   Wolfram Sang

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkPeBIACgkQD27XaX1/VRvvigCfa8cFb27a+PVl6zgc4Tt48+sP
9S8AnjXcnJ7XABCz7DPD2hoaV/vwCzs9
=x46G
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
