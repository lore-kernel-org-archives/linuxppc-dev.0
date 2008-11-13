Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 961A3DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 05:42:27 +1100 (EST)
Date: Thu, 13 Nov 2008 19:42:18 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: [PATCH v1] RS485 support for MPC5200x_psc_uart
Message-ID: <20081113184218.GA11602@pengutronix.de>
References: <633A55242A59C7488FAAF5A6850929984B813E@SRVEXC01.sts.saurer.vpn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B813E@SRVEXC01.sts.saurer.vpn>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Thu, Nov 13, 2008 at 04:48:30PM +0100, Lehmann, Hans (Ritter Elektronik)=
 wrote:

> Adds rs485 support for MPC52xx_psc_uart

Please be more specific. What exactly was done/modified to have
RS485-support.

Please also read SubmittingPatches and CodingStyle in the Documentation
directory and adapt your patch accordingly. For example: Send patches
inlined, this makes reviewing a lot easier. Don't use magic numbers. Use
spaces around operators. All this helps maintaining your code in the
future.

> COM1 is console and not selectable.

COM1 is rarely selectable in Linux ;)

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkcdQoACgkQD27XaX1/VRtM6ACfcjyEiBTahWudbrUBHw9g2Ilm
J+4AoKxOhuq9UciSBJVacnD1fk9Eze+F
=xTXF
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
