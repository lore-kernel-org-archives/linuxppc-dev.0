Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id C503EDDDDF
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 09:39:20 +1100 (EST)
Date: Thu, 27 Nov 2008 23:39:14 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: [PATCH v1] RS485 support for MPC5200x_psc_uart
Message-ID: <20081127223914.GA19060@pengutronix.de>
References: <633A55242A59C7488FAAF5A6850929984B813E@SRVEXC01.sts.saurer.vpn>
	<20081113184218.GA11602@pengutronix.de>
	<633A55242A59C7488FAAF5A6850929984B8143@SRVEXC01.sts.saurer.vpn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B8143@SRVEXC01.sts.saurer.vpn>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Mon, Nov 17, 2008 at 04:27:45PM +0100, Lehmann, Hans (Ritter Elektronik)=
 wrote:

> Criticism is welcome

Well, there are still some issues concerning coding-style and design,
but those can be worked out, I guess. Still, there is one conceptual
question I'd like to ask:

Have you seen the TxRTS feature in Mode Register 2? It looks to me that
it does the same (in hardware) what you achieve with the
*_rts_clear-function and the TX_EMPTY interrupt. Or am I wrong?

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkvIZIACgkQD27XaX1/VRucPACfZWjB2iH4s8XtSjnGhNZl1n3D
rWwAnjrOBAlMwoyzugNKy0wxXtsLioHM
=spzj
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
