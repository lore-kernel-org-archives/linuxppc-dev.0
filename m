Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E2AF72C00BA
 for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2012 01:26:22 +1100 (EST)
Date: Sat, 3 Nov 2012 15:26:15 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] powerpc: 52xx: nop out unsupported critical IRQs
Message-ID: <20121103142615.GB24952@pengutronix.de>
References: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>
 <1349947155-11540-1-git-send-email-w.sang@pengutronix.de>
 <20121020135955.709e20a8@wker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
In-Reply-To: <20121020135955.709e20a8@wker>
Cc: John Bonesio <bones@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Currently, when booting MPC52xx based platforms, we get:
> >=20
> >         mpc52xx_irqhost_map: invalid irq: virq=3D16, l1=3D0, l2=3D3
> >         irq: irq-16=3D=3D>hwirq-0x3 mapping failed: -22
> >         [WARNing skipped]
> >=20
> > The warning is wrong since the mapping itself is valid. However, there =
is no
> > support for that type of IRQ currently. Print a proper warning and bind=
 the irq
> > to a no_irq chip.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> applied, thanks!

Thanks, can we have that in 3.7. already?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCVKYcACgkQD27XaX1/VRv3egCgmauM/3MRAixHI2Y8/dEQTR7b
0JoAnRYxCQ7VAuuNQJv3x8Ci1xK978Ze
=c5cq
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
