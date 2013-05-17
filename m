Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B77862C0098
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 18:51:21 +1000 (EST)
Message-ID: <5195EF74.8070005@pengutronix.de>
Date: Fri, 17 May 2013 10:51:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: allow compilation on arm and powerpc
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
 <20130517020351.GE3893@S2101-09.ap.freescale.net>
In-Reply-To: <20130517020351.GE3893@S2101-09.ap.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BTQAAMIKHERLPINUMOQI"
Cc: Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 U Bhaskar-B22300 <B22300@freescale.com>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BTQAAMIKHERLPINUMOQI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/17/2013 04:03 AM, Shawn Guo wrote:
> Hi Marc,
>=20
> On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
>> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
>> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compila=
tion on
>> all arm and powerpc platforms.
>=20
> I'm generally fine with the approach.  But with Kconfig symbol
> IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
> platform-flexcan.o work?
>=20
> arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXC=
AN) +=3D platform-flexcan.o

Doh! - I've removed too much, will change.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BTQAAMIKHERLPINUMOQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGV73gACgkQjTAFq1RaXHOhLACfXhnZQvq8oFaR1qHQyBycdj4z
or4AnRO8KuSrpX8kUrwFu2rESmefa4Av
=5VdO
-----END PGP SIGNATURE-----

------enig2BTQAAMIKHERLPINUMOQI--
